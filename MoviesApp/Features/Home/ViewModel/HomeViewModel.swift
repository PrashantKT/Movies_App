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
    
    private (set) var topTrendingMoviePagination = MoviePagination()
   
    
    
    func trendingMoviesScroll(at movie:Movie) {
        
        guard self.topTrendingMoviePagination.isMoreRecordAvailable,self.topTrendingMoviePagination.isRequestingNewpage == false else {
            return
        }
        
        if let lastItem = self.topTrendingMovies?.results?.last {
            if lastItem == movie {
                print("#1 Requesting New page")
                topTrendingMoviePagination.lastRecord = movie
                loadNextPageOfTrendingMovies()
            }
        }
    }
    
    private func loadNextPageOfTrendingMovies() {
        
        topTrendingMoviePagination.task?.cancel()
        let task =  Task {
            topTrendingMoviePagination.currentPage += 1
            self.topTrendingMoviePagination.isRequestingNewpage = true

            let movies =  await fetchMoviewBasedOnSelectedGenres()
            DispatchQueue.main.async {
                self.topTrendingMovies?.results?.append(contentsOf: movies?.results ?? [])
                print("#4 Refresh Data")
                self.topTrendingMoviePagination.isRequestingNewpage = false

            }

        }
        topTrendingMoviePagination.task = task
    }
    
    func fetchTrendingMovies() async -> MovieResponse? {
       
        let para:[String:Any] = ["page":topTrendingMoviePagination.currentPage]
        let movies = await movieService.fetchTrending(queryPara: para)
        try? Task.checkCancellation()
        switch movies {
        case .success(let res):
            self.topTrendingMoviePagination.currentPage = res.page
            self.topTrendingMoviePagination.isMoreRecordAvailable = res.page < res.totalPages
            print("#3 Return Result")

            return res
        case .failure(let error):
            errormsg =  error.customMessage
            
        }
        return nil
    }
    
    func refreshMoviesOnGenreSelection() async -> MovieResponse? {
        let queryPara:[String:Any] = ["with_genres":selectedGenre.id,"page":topTrendingMoviePagination.currentPage]
        let movies = await movieService.discoverMovies(queryPara: queryPara)
        switch movies {
        case .success(let res):
            self.topTrendingMoviePagination.currentPage = res.page
            self.topTrendingMoviePagination.isMoreRecordAvailable = res.page < res.totalPages

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
    
    private func fetchMoviewBasedOnSelectedGenres() async -> MovieResponse? {
        if selectedGenre == .topTrending {
            return await fetchTrendingMovies()
        } else {
            return await refreshMoviesOnGenreSelection()

        }
    }
    
    func genreChanged() {
        Task {
            self.topTrendingMoviePagination.reset()
            self.topTrendingMovies = await fetchMoviewBasedOnSelectedGenres()
        }
    }
    
}
