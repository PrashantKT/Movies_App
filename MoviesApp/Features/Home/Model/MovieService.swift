//
//  MovieService.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation

protocol MovieServiable {
    func fetchTopRated() async -> Result<MovieResponse,RequestError>
    func fetchTrending(queryPara:[String:Any]) async -> Result<MovieResponse,RequestError>
    func fetchGenre() async -> Result<GenreResponse,RequestError>
    func discoverMovies(queryPara:[String:Any]) async -> Result<MovieResponse,RequestError>
    func fetchMovieDetails(movieID:Int) async -> Result<MovieDetail,RequestError>
    func fetchMovieCast(movieID:Int) async -> Result<MovieCastCrewResponse,RequestError>
    func fetchReviews(movieID: Int) async -> Result<MovieReviewResponse, RequestError>
}

actor MovieService : MovieServiable,HttpClient {
    func fetchTopRated() async -> Result<MovieResponse,RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.topRated, responseModel: MovieResponse.self)
    }
    
    func fetchTrending(queryPara:[String:Any]) async -> Result<MovieResponse,RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.trending(para: queryPara), responseModel: MovieResponse.self)
    }
    
    func fetchGenre() async -> Result<GenreResponse,RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.genre, responseModel: GenreResponse.self)
    }
    
    func discoverMovies(queryPara:[String:Any]) async -> Result<MovieResponse,RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.discoverMovies(para: queryPara), responseModel: MovieResponse.self)
    }
    
    func fetchMovieDetails(movieID: Int) async -> Result<MovieDetail, RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.movieDetails(id: movieID), responseModel: MovieDetail.self)
    }
    func fetchMovieCast(movieID: Int) async -> Result<MovieCastCrewResponse, RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.movieCast(id: movieID), responseModel: MovieCastCrewResponse.self)
    }
    func fetchReviews(movieID: Int) async -> Result<MovieReviewResponse, RequestError> {
        await sendRequest(endPoint: MoviesEndpoint.moviesReview(id: movieID), responseModel: MovieReviewResponse.self)
    }
}
