//
//  MovieImageLoader.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import SwiftUI

struct MovieImageLoader: View {
    let movie:Movie
    let cardType:MovieCardType
    var body: some View {
        
        AsyncImage(url: URL(string: cardType.baseURL + movie.posterPath)) { image in
            image
                .resizable()
                .scaledToFill()
            
        } placeholder: {
            ZStack {
                Color.AppGrayColor1
                Text(movie.title)
                    .font(.poppins(.Light, size: 12))
                
            }
        }
        
    }
}

struct MovieImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        MovieImageLoader(movie: Movie.previewMovie,cardType: .grid)
    }
}
