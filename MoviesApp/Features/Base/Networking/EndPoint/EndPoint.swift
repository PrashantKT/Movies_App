//
//  EndPoint.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation


protocol EndPoint {
    var path:String {get}
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItem:[String:Any]? {get}
}

extension EndPoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.themoviedb.org"
    }
}

