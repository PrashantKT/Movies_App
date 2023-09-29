//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation

enum ApiRequestStatus<T:Codable>:Equatable {
    static func == (lhs: ApiRequestStatus<T>, rhs: ApiRequestStatus<T>) -> Bool {
        switch (lhs,rhs) {
        case (.loading , .loading):
            return true
        case (.failed ,.failed) :
            return true
        case (.fetched,.fetched):
            return true
        default:
            return false
        }
    }
    
    case loading
    case fetched(data:T)
    case failed(error:RequestError)
    
    var fetchedData : T? {
        if case .fetched(let data) = self {
            return data
        }
        return nil
    }
}

@MainActor
class HomeViewModel:ObservableObject {
    
    var movieService:MovieServiable
    init(service:MovieServiable) {
        self.movieService = service
    }
    @Published var searchText = ""

    @Published var genres = [Genre]()
    @Published var selectedGenre:Int = Genre.topTrending.id

    @Published var errormsg = ""
    @MainActor @Published var isLoading = true
    
    @Published var selectedMovie:Movie?
    @Published var isMovieSelected = false
    
    @Published var topRatedMovie:ApiRequestStatus<MovieResponse?> = .loading
    @Published var topTrendingMovies:ApiRequestStatus<MovieResponse?> = .loading

    private (set) var topTrendingMoviePagination = MoviePagination()
    
    
    func trendingMoviesScroll(at movie:Movie) {
        
        guard self.topTrendingMoviePagination.isMoreRecordAvailable,self.topTrendingMoviePagination.isRequestingNewpage == false else {
            return
        }
        
        if let lastItem = self.topTrendingMovies.fetchedData??.results?.last {
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
                var currentData = self.topTrendingMovies.fetchedData??.results
                currentData?.append(contentsOf: movies?.results ?? [])
                currentData = currentData?.uniqued()
                
                if var finalMovieRes = self.topTrendingMovies.fetchedData {
                    finalMovieRes?.results = currentData
                    self.topTrendingMovies = .fetched(data: finalMovieRes)
                } else if let movies  = movies{
                    self.topTrendingMovies = .fetched(data: movies)
                }
                
                self.topTrendingMoviePagination.isRequestingNewpage = false

            }

        }
        topTrendingMoviePagination.task = task
    }
    
    func fetchTrendingMovies() async -> MovieResponse? {
 
        //Only Load if we are loading first page
        if topTrendingMoviePagination.currentPage == 1{
            self.topTrendingMovies = .loading
        }

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
            self.topTrendingMovies = .failed(error: error)

        }
        return nil
    }
    
    func refreshMoviesOnGenreSelection() async -> MovieResponse? {

        //Only Load  status if we are loading first page
        if topTrendingMoviePagination.currentPage == 1{
            self.topTrendingMovies = .loading
        }
        let queryPara:[String:Any] = ["with_genres":selectedGenre,"page":topTrendingMoviePagination.currentPage]
        let movies = await movieService.discoverMovies(queryPara: queryPara)
        switch movies {
        case .success(let res):
            self.topTrendingMoviePagination.currentPage = res.page
            self.topTrendingMoviePagination.isMoreRecordAvailable = res.page < res.totalPages

            return res
        case .failure(let error):
            errormsg =  error.customMessage
            self.topTrendingMovies = .failed(error: error)

        }
        return nil
    }
    
    func fetchTopRatedMovies() async -> MovieResponse?  {
        topRatedMovie = .loading
        let movies = await movieService.fetchTopRated()
        switch movies {
        case .success(let res):
            print("Finished fetchTopRatedMovies ")
            return res
        case .failure(let error):
            errormsg =  error.customMessage
            topRatedMovie = .failed(error: error)
        }
        return nil

    }
    
    func fetchGenres()  async -> GenreResponse? {
        let movies = await movieService.fetchGenre()
        switch movies {
        case .success(let res):
            print("Finished fetchGenres ")

            return res
        case .failure(let error):
            errormsg =  error.customMessage
            
        }
        return nil

    }
    
    
    func fetchMoviesAndGenres() {
        guard self.topTrendingMovies == .loading,  self.topRatedMovie == .loading else {
            return
        }
        Task {
            isLoading = true
            async let topRatedMovies = await fetchTopRatedMovies()
            async let genres = await fetchGenres()
            
            if let _topRatedMovie =  await topRatedMovies {
                self.topRatedMovie = .fetched(data: _topRatedMovie) // await topRatedMovies
            }
            
            self.genres = [Genre.topTrending] +  (await genres?.genres ?? [])

            genreChanged()

            print("topTrending Movie \(self.genres)")
            isLoading = false
        }
    }
    
    private func fetchMoviewBasedOnSelectedGenres() async -> MovieResponse? {
        if selectedGenre == Genre.topTrending.id {
            return await fetchTrendingMovies()
        } else {
            return await refreshMoviesOnGenreSelection()

        }
    }
    
    func genreChanged() {
        Task {
            self.topTrendingMoviePagination.reset()
            if let movies = await fetchMoviewBasedOnSelectedGenres() {
                self.topTrendingMovies = .fetched(data: movies)

            }
        }
    }
    
    var isErrorInTopTrendingFetch:Bool {
        if case .failed =  topTrendingMovies {
         return true
        }
        return false
    }
    
    var gridItemsCount: Int {
        return isErrorInTopTrendingFetch ?  1 :  3
       
    }
    
}
