//
//  MovieService.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation

protocol MovieServiable {
    func fetchTopRated() async -> Result<MovieResponse,RequestError>
    func fetchTrending() async -> Result<MovieResponse,RequestError>
    func fetchGenre() async -> Result<GenreResponse,RequestError>
    func discoverMovies(queryPara:[String:Any]) async -> Result<MovieResponse,RequestError>

}

actor MovieService : MovieServiable,HttpClient {
    func fetchTopRated() async -> Result<MovieResponse,RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.topRated, responseModel: MovieResponse.self)
    }
    
    func fetchTrending() async -> Result<MovieResponse,RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.trending, responseModel: MovieResponse.self)
    }
    
    func fetchGenre() async -> Result<GenreResponse,RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.genre, responseModel: GenreResponse.self)
    }
    
    func discoverMovies(queryPara:[String:Any]) async -> Result<MovieResponse,RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.discoverMovies(para: queryPara), responseModel: MovieResponse.self)
    }
}
