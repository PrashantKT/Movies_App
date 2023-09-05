import UIKit

var greeting = "Hello, playground"



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


let values = ["include_video":false,"genre_id":5,"lang" : "eng"] as [String : Any]

print(values.queryString())
