//
//  MovieImageView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import SwiftUI

struct MovieCardView : View {
    let movie:Movie
    let cardType:MovieCardType
    var body: some View {
        
        MovieImageLoader(movie: movie,cardType: cardType)
            .frame(width: screenWidth * cardType.widthPercentage,height: screenWidth * cardType.heightPercentage)
            .clipShape(RoundedRectangle(cornerRadius: 12))

        
    }
}

struct MovieCardView_Preview:PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: Movie.previewMovie,cardType: .poster)
    }
}
