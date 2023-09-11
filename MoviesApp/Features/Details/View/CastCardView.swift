//
//  CastCardView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 11/09/23.
//

import SwiftUI

struct CastCardView: View {
    var cast:Cast
    var body: some View {

        VStack {
            AsyncImage(url: URL(string: cast.profileImage ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.AppGrayColor2)

            }
            .frame(height:(screenWidth - 40) * 0.4)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding([.horizontal,.top])
            Text(cast.name)
                .lineLimit(1)
                .font(.poppins(.Bold, size: 16))
                .foregroundColor(.AppBackgroundColor)
            Text(cast.character ?? "-")
                .lineLimit(2)
                .font(.poppins(.Light, size: 12))
                .padding(.bottom)
                .foregroundColor(.AppGrayColor1)

        }
        .background {
            RoundedRectangle(cornerRadius: 8).fill(Color.white)
                .shadow(color: Color.white.opacity(0.5),radius: 8,x: 5,y: 5)
                .shadow(color: Color.black.opacity(0.5),radius: 8,x: -5,y: -5)
        }
        .frame(width:(screenWidth - 40) * 0.4)

//        .clipShape(RoundedRectangle(cornerRadius: 8))

        
    }
}

struct CastCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            CastCardView(cast: MovieCastCrewResponse.previewMovie.cast[0])
            CastCardView(cast: MovieCastCrewResponse.previewMovie.cast[1])
        }

            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
    }
}
