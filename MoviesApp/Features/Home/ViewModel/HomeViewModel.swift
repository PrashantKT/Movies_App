//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation

@MainActor
class HomeViewModel:ObservableObject {
    
    var movieService:MovieServiable
    init(service:MovieServiable) {
        self.movieService = service
    }
    @Published var searchText = ""
    @Published var topRatedMovies:MovieResponse?
    @Published var topTrendingMovies:MovieResponse?

    @Published var genres = [Genre]()
    @Published var selectedGenre:Genre = .topTrending

    @Published var errormsg = ""
    @MainActor @Published var isLoading = false
    
   
    
    func fetchTrendingMovies() async -> MovieResponse? {
        let movies = await movieService.fetchTrending()
        switch movies {
        case .success(let res):
            return res
        case .failure(let error):
            errormsg =  error.customMessage
            
        }
        return nil
    }
    
    func fetchTopRatedMovies() async -> MovieResponse?  {
        let movies = await movieService.fetchTopRated()
        switch movies {
        case .success(let res):
            return res
        case .failure(let error):
            errormsg =  error.customMessage
            
        }
        return nil

    }
    
    func fetchGenres()  async -> GenreResponse? {
        let movies = await movieService.fetchGenre()
        switch movies {
        case .success(let res):
            return res
        case .failure(let error):
            errormsg =  error.customMessage
            
        }
        return nil

    }
    
    func refreshMoviesOnGenreSelection() async -> MovieResponse? {
        let queryPara:[String:Any] = ["with_genres":selectedGenre.id]
        let movies = await movieService.discoverMovies(queryPara: queryPara)
        switch movies {
        case .success(let res):
            return res
        case .failure(let error):
            errormsg =  error.customMessage
            
        }
        return nil
    }
    
    func fetchMoviesAndGenres() {
        Task {
            isLoading = true
            async let topRatedMovies = await fetchTopRatedMovies()
            async let topTrendingMovies = await fetchTrendingMovies()
            async let genres = await fetchGenres()

            self.topRatedMovies = await topRatedMovies
            self.topTrendingMovies = await topTrendingMovies
            self.genres = [Genre.topTrending] +  (await genres?.genres ?? []) 
            

            isLoading = false
        }
    }
    
  
    
    
    
}
