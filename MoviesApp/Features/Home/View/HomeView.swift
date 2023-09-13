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
            .task {
                vm.fetchMoviesAndGenres()
            }
            .onChange(of: vm.selectedGenre) { newValue in
                vm.genreChanged()
            }
            .modifier(LoaderView(isLoading: $vm.isLoading))
            .navigationDestination(isPresented: $vm.isMovieSelected) {
                if let binding = Binding<Movie>($vm.selectedMovie) {
                    DetailsView(movie: binding)
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
                            .onTapGesture {
//                                vm.selectedMovie = movie
//                                vm.isMovieSelected.toggle()
                                
                                var transaction = Transaction()
                                transaction.disablesAnimations = true
                                withTransaction(transaction) {
                                    vm.selectedMovie = movie
                                    vm.isMovieSelected.toggle()
                                }
                            }
                        
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
                            } .onTapGesture {
                                vm.selectedMovie = movie
                                vm.isMovieSelected.toggle()

                            }
                    }
                } header: {
                    SectionSelectionView(selectedGenre: $vm.selectedGenre, genre: vm.genres, nameSpace: animation)
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
