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
        NavigationStack {
            ScrollView(showsIndicators: true) {
                
                VStack(alignment: .leading,spacing: 20) {
                    Text("What do you want to watch?")
                        .font(.poppins(.Bold, size: 20))
                    Searchbar(searchText: $vm.searchText)
                    topHorizontalScrollView
                    trendingItemsView
                }
            }
    
            .preferredColorScheme(.dark)
            .padding([.top,.leading,.trailing])
            .background(Color.AppBackgroundColor.ignoresSafeArea())
            .onAppear {
                vm.fetchMoviesAndGenres()
            }
            .onChange(of: vm.selectedGenre) { newValue in
                vm.genreChanged()
            }
            .overlay{
                if vm.isLoading {
                    ZStack {
                        Color.black.opacity(0.7)
                            .ignoresSafeArea()
                        ProgressView()
                            .frame(width: 55,height: 55)
                    }
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
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 20), count: 3),pinnedViews: .sectionHeaders) {
                Section {
                    ForEach(topTrending) {movie in
                        MovieCardView(movie: movie, cardType: .grid)
                            .id(movie.id)
                            .onAppear {
                                 vm.trendingMoviesScroll(at: movie)
                            }
                    }
                } header: {
                    GenreView(selectedGenre: $vm.selectedGenre, genre: vm.genres, nameSpace: animation)
                        .background(Color.AppBackgroundColor)
                        .padding(.bottom,15)
                    
                } footer: {
                    VStack {
                        ProgressView()
                            .padding(.top,20)
                            .opacity(vm.topTrendingMoviePagination.isMoreRecordAvailable ? 1 : 0)
                    }
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
