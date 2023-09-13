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
                .font(.poppins(.Bold, size: 14))
                .foregroundColor(.white)
                .padding(.horizontal,2)
            Text(cast.character ?? "-")
                .lineLimit(2)
                .font(.poppins(.Light, size: 9))
                .padding(.bottom)
                .foregroundColor(.white)

        }
        
        .background {
            RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(0.8))
                .background {
//                    RoundedRectangle(cornerRadius: 8).stroke(Color.red,lineWidth:2)

                }
                .shadow(color: Color.white.opacity(0.2),radius: 5,x: 5,y: 5)
                .overlay {
                    RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.35))
                }
        }
        
        .frame(width:(screenWidth - 40) * 0.4)
       

//        .clipShape(RoundedRectangle(cornerRadius: 8))

        
    }
}

struct CastCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            CastCardView(cast: MovieCastCrewResponse.previewMovie.cast[0])
        }

            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.AppBackgroundColor)
    }
}
