//
//  DetailsView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 06/09/23.
//

import SwiftUI

struct DetailsView: View {
    
    @Binding var movie:Movie
    var nameSpace:Namespace.ID

    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            ZStack {
                GeometryReader {proxy in
                    let size = proxy.frame(in: .global)
                    MovieImageLoader(movie: movie, cardType: .poster,imageType:.backdrop)
                        .frame(width: size.width,height:size.height)
                        .clipped()
                    
                }
                .frame(height:screenHeight * 0.35)
                HStack {
                    MovieImageLoader(movie: movie,cardType: .grid)
                        .frame(width: screenWidth * 0.3,height: screenWidth * 0.4)
                        .matchedGeometryEffect(id: movie.id, in: nameSpace)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: Color.black.opacity(0.2), radius: 5,x: 5,y: 5)
                        .shadow(color: Color.white.opacity(0.2), radius: 5,x: -5,y:-5)

                    Text(movie.title)
                        .font(.poppins(.SemiBold, size: 25))
                }
                .padding()
                .offset(y:screenWidth * 0.2)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomLeading)
            }
            ScrollView {
                Text("PENDING")
            }
            .padding(.top,screenWidth * 0.2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.AppBackgroundColor.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .navigationTitle(movie.title)
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(movie.title)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.bold)
                        .tint(Color.white)
                }

            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    @Namespace static var nameSpace
    static var previews: some View {
        
        NavigationStack {
            DetailsView(movie: .constant(Movie.previewMovie), nameSpace: nameSpace)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Movie.previewMovie.title)
        }
    }
}
