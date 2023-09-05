//
//  MovieEndPoint.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation

enum MoviesEndpoint {
    case topRated
    case trending(para:[String:Any])
    case genre
    case moviesReview(id: Int)
    case discoverMovies(para:[String:Any])

}

extension MoviesEndpoint : EndPoint {
    var path:String {
        switch self {
        case .trending:
            return "/3/trending/movie/week"
        case .topRated:
            return "/3/movie/top_rated"
        case .genre:
            return "/3/genre/movie/list"
        case .moviesReview( let movieId):
            return "/3/movie/\(movieId)/reviews"
        case .discoverMovies:
            return "/3/discover/movie"
        }
        
    }
    
    var method: RequestMethod {
        switch self {
        case .topRated,.trending,.genre,.moviesReview(id: _),.discoverMovies:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
            
        case .topRated,.trending,.genre,.moviesReview,.discoverMovies:
            return  [
                "Authorization": "Bearer \(Constants.token)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var queryItem: [String : Any]? {
        switch self {
        case .discoverMovies(let para):
            return para
        case .trending(let para):
            return para
        default:
            return nil
        }
    }
    
}
