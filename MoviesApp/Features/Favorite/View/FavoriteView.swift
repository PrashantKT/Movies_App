//
//  FavoriteView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 28/09/23.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var mainVM: MainViewModel
    @State private var favMovies = [Movie]()
    var body: some View {
        NavigationStack {
            ZStack {
                Color.AppBackgroundColor
                    .ignoresSafeArea()
                if !favMovies.isEmpty {
                    
                    trendingItemsView
                } else{
                    VStack {
                        Image(systemName: "rectangle.badge.xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.white)
                        Text("No favorite movies found.")
                            .foregroundColor(.white.opacity(0.8))
                        
                    }
                    
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
            }

        }
        
        .onAppear {
            mainVM.resetBadgeCount()
        }
        .task {
            let mainMovies = await mainVM.favRepo.readFavorite()
            favMovies = mainMovies
//#if DEBUG
//            favMovies = [Movie.previewMovie,Movie.previewMovie]
//#endif
//
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    var trendingItemsView : some View {
        List {
            ForEach(favMovies) {movie in
                favMovieItem(movie: movie)
                    .id(movie.id)
                
                    .listRowInsets(EdgeInsets())
                    .listRowBackground (
                        RoundedRectangle(cornerRadius: 9).fill(Color.AppGrayColor1)
                            .padding(12)
                    )
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        
                    }

            }
            .onDelete { indexSet in
                Task {
                    for index in indexSet {
                        let data = favMovies[index]
                        try? await mainVM.favRepo.removeFavorite(movie:data)
                        favMovies.remove(at: index)
                    }
//                    mainVM.favRepo.removeFavorite(movie:favMovies[indexSet.])
                }
            }

            
        }
        .listStyle(.plain)

    }
    
    @ViewBuilder func favMovieItem(movie:Movie) -> some View {
        HStack(alignment: .top, spacing:12) {
            MovieImageLoader(movie: movie, cardType: .grid)
                .frame(width:screenWidth * 0.23,height:screenWidth * 0.3)
                .clipped()
                .padding(.vertical,4)
                .padding(.trailing,12)
            VStack(alignment: .leading,spacing: 12) {
                Text(movie.title)
                    .font(.poppins(.Bold, size: 18))
                    .foregroundColor(.white)
                Text(movie.overview ?? "")
                    .font(.poppins(.Medium, size: 14))
                    .lineLimit(3)
                    .foregroundColor(.gray)
                HStack {
                    Text(movie.releaseDate)
                        .font(.poppins(.Medium, size: 14))
                        .foregroundColor(.white)
                    Spacer()
                    if let avg = movie.voteAverage {
                        HStack {
                            Image(systemName: "star")
                            Text(String(format: "%0.1f", avg))
                        }
                        .font(.poppins(.Bold, size: 14))
                        .kerning(0.12)
                        .foregroundColor(.orange)
                        .padding(.trailing,4)
                    }
                }
            }
            .swipeActions {
                
            }
        }
        .padding()
        
    }
}


struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(MainViewModel())
    }
}
