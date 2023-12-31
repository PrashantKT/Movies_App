//
//  HttpClient.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation

protocol HttpClient {
    func sendRequest<T:Codable>(endPoint:EndPoint,responseModel:T.Type) async -> Result<T,RequestError>
}

extension HttpClient {
    func sendRequest<T:Codable>(endPoint:EndPoint,responseModel:T.Type) async -> Result<T,RequestError> {
        
      
        guard let url = endPoint.createURL() else {
            return .failure(.invalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.header
        print(request)

        do {
            
            let (data, response)  =  try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

//            print(String.init(data: data, encoding: .utf8) ?? "NO DATA")
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    return .success(decodedResponse)

                } catch {
                    print(error)
                    return .failure(.decode)

                }
             
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }

        } catch {
            return .failure(.unknown)
        }
    }

}
