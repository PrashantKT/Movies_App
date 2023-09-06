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
    @Published var movieDetailsResponse:MovieDetail? = MovieDetail.previewMovie
    @Published var movieRevies:MovieReviewResponse? = MovieReviewResponse.previewMovie
    @Published var movieCastAndCrew:MovieCastCrewResponse? = MovieCastCrewResponse.previewMovie

    @Published var errorMsg = ""
    @Published var isLoading = false
    
    @Published var currentTab:Int = DetailSectionTab.aboutMovie.rawValue
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func fetchMoveDetails(id:Int) {
        Task {
            isLoading = true
            async let movieDetails = await fetchMoveDetails(id: id)
            async let movieReview = await fetchMovieReviews(id: id)
            async let castAndCrewData = await fetchMovieCastAndCrew(id: id)
            
            self.movieDetailsResponse = await movieDetails
            self.movieRevies = await movieReview
            self.movieCastAndCrew = await castAndCrewData

            
            isLoading = false
        }
    }
    
    func fetchMoveDetails(id:Int) async -> MovieDetail? {
        let res =  await movieService.fetchMovieDetails(movieID:id)
        switch res {
        case .failure(let error):
            errorMsg = error.customMessage
            return nil
        case .success(let details):
            return details
        }
    }
    
    func fetchMovieReviews(id:Int) async -> MovieReviewResponse? {
        let res =  await movieService.fetchReviews(movieID: id)
        switch res {
        case .failure(let error):
            errorMsg = error.customMessage
            return nil
        case .success(let details):
            return details
        }
    }
    
    func fetchMovieCastAndCrew(id:Int) async ->MovieCastCrewResponse? {
        let res =  await movieService.fetchMovieCast(movieID: id)
        switch res {
        case .failure(let error):
            errorMsg = error.customMessage
            return nil
        case .success(let details):
            return details
        }
    }
   
    func fetchGenres() -> String {
        return "\((movieDetailsResponse?.genres ?? []).map{$0.name}.joined(separator: ","))"
    }
    
}
