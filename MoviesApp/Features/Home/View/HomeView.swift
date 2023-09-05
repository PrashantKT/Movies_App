//
//  HomeView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject  var vm = HomeViewModel(service: MovieService())
    @Namespace var animation
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading,spacing: 20) {
                Text("What do you want to watch?")
                    .font(.poppins(.Bold, size: 20))
                Searchbar(searchText: $vm.searchText)
                topHorizontalScrollView
                LazyVStack(alignment: .leading,spacing:20,pinnedViews: .sectionHeaders) {
                    Section{
                        trendingItemsView
                    } header: {
                        GenreView(selectedGenre: $vm.selectedGenre, genre: vm.genres, nameSpace: animation)
                            .background(Color.AppBackgroundColor)
                    }
                }
             
            }
        }
        .preferredColorScheme(.dark)
        .padding([.top,.leading,.trailing])
        .background(Color.AppBackgroundColor.ignoresSafeArea())
        .onAppear {
            vm.fetchMoviesAndGenres()
        }
        .onChange(of: vm.selectedGenre) { newValue in
            Task {
                if newValue == .topTrending {
                    self.vm.topTrendingMovies = await vm.fetchTrendingMovies()
                } else {
                    self.vm.topTrendingMovies = await vm.refreshMoviesOnGenreSelection()

                }
            }
        }
    }
    
    @ViewBuilder
    var topHorizontalScrollView : some View {
        if let movies = vm.topRatedMovies?.results {
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing:30) {
                    ForEach(movies) {movie in
                        MovieCardView(movie: movie, cardType: .poster)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var trendingItemsView : some View {
        if let topTrending = vm.topTrendingMovies?.results {
            VStack {
                ScrollViewReader { proxy in
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 20), count: 3)) {
                        ForEach(topTrending) {movie in
                            MovieCardView(movie: movie, cardType: .grid)
                                .onAppear {
                                    vm.trendingMoviesScroll(at: movie)
                                }
                                .tag(movie.id)
                        }
                    }
                   
                }
                VStack {
                    ProgressView()
                        .padding(.top,20)
                        .opacity(vm.topTrendingMoviePagination.isRequestingNewpage ? 1 : 0)
                }
            }
        }
    }
   
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
