//
//  Dictioanry.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {

    func queryString() -> String? {
        var urlComponents = URLComponents(url: URL(string:"www.google.com")!, resolvingAgainstBaseURL: false)

        
        let queryItems = self.map{
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        
        urlComponents?.queryItems = queryItems
       return  urlComponents?.query

    }
}
