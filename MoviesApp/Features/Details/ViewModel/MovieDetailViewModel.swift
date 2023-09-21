//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 06/09/23.
//

import Foundation
import SwiftUI

enum DetailSectionTab:Int,CaseIterable {
    case aboutMovie = 0
    case reviews
    case cast
    
    var displayText:String {
        switch self {
        case .aboutMovie:
            return "About Movie "
        case .reviews:
            return "Reviews"
        case .cast:
            return "Cast"
        }
    }
    
    static var displayAsGenre:[Genre] = Self.allCases.map{Genre.init(id: $0.rawValue, name: $0.displayText)}
}

class MovieDetailViewModel : ObservableObject {
    
    var movieService:MovieService
    
    @Published var movieDetailsResponse:ApiRequestStatus<MovieDetail> = .loading
    @Published var movieRevies:ApiRequestStatus<MovieReviewResponse> =  .loading
    @Published var movieCastAndCrew:ApiRequestStatus<MovieCastCrewResponse> =  .loading

    @Published var errorMsg = ""
//    @Published var isLoading = false
    
    @Published var currentTab:Int = DetailSectionTab.aboutMovie.rawValue

    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    @MainActor
    func fetchMoveDetails(id:Int) {
        Task {
//            isLoading = true
            async let movieDetails = await fetchMoveDetails(id: id)
            async let movieReview = await fetchMovieReviews(id: id)
            async let castAndCrewData = await fetchMovieCastAndCrew(id: id)
            
            if let _movieDetailsResponse = await movieDetails {
                self.movieDetailsResponse = .fetched(data: _movieDetailsResponse)
            }
            if let _movieRevies = await movieReview {
                self.movieRevies = .fetched(data: _movieRevies)
            }
            if let _movieCastAndCrew = await castAndCrewData {
                movieCastAndCrew = .fetched(data: _movieCastAndCrew)
            }

            
//            isLoading = false
        }
    }
    
    @MainActor
    func fetchMoveDetails(id:Int) async -> MovieDetail? {
        movieDetailsResponse = .loading
        let res =  await movieService.fetchMovieDetails(movieID:id)
        switch res {
        case .failure(let error):
            errorMsg = error.customMessage
            movieDetailsResponse = .failed(error: error)
            return nil
        case .success(let details):
            return details
        }
    }
    
    @MainActor
    func fetchMovieReviews(id:Int) async -> MovieReviewResponse? {
        movieDetailsResponse = .loading
        let res =  await movieService.fetchReviews(movieID: id)
        switch res {
        case .failure(let error):
            errorMsg = error.customMessage
            movieDetailsResponse = .failed(error: error)
            return nil
        case .success(let details):
            return details
        }
    }
    
    @MainActor
    func fetchMovieCastAndCrew(id:Int) async ->MovieCastCrewResponse? {
        movieCastAndCrew = .loading
        let res =  await movieService.fetchMovieCast(movieID: id)
        switch res {
        case .failure(let error):
            errorMsg = error.customMessage
            movieCastAndCrew = .failed(error: error)
            return nil
        case .success(let details):
            return details
        }
    }
   
    func fetchGenres() -> String {
        return "\((movieDetailsResponse.fetchedData?.genres ?? []).map{$0.name}.joined(separator: ","))"
    }
    
}
