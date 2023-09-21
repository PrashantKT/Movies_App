//
//  MovieReviewAuthorCardView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 10/09/23.
//

import SwiftUI

struct MovieReviewAuthorCardView: View {
    @State private var lineLimit:Int? = 2
    @Binding  var isLoadingView:Bool
    var movieReview:MovieReview?
    var body: some View {

        VStack(alignment: .leading) {
            HStack(alignment:.top) {
                avtarView
                    .shimmerView(isLoading: $isLoadingView)
                VStack(alignment:.leading,spacing:4) {
                    Text("A Review By \(movieReview?.author ?? "")")
                        .font(.poppins(.Bold, size: 14))
                        .shimmerView(isLoading: $isLoadingView)

                    HStack(spacing:5) {
                        if let rating = movieReview?.authorDetails?.rating {
                            HStack(spacing:2) {
                                Image(systemName: "star.fill")
                                Text("\(rating)")
                                    .padding(2)
                            }
                            .font(.poppins(.Bold, size: 12))
                            .padding(.horizontal,6)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Capsule())
                            .shimmerView(isLoading: $isLoadingView)

                        }
                        
                        Text("Written By \(movieReview?.author ?? "")")
                            .font(.poppins(.Light, size: 12))
                            .lineLimit(2)
                            .shimmerView(isLoading: $isLoadingView)

                    }

                    
                    VStack(alignment:.leading,spacing:2) {
                        Text(movieReview?.content ?? "")
                            .lineLimit(lineLimit)
                            .font(.poppins(.Light, size: 12))
                        
                        Button(lineLimit == nil ? "Read less" :  "Read More") {
                            lineLimit =  lineLimit == nil ?  2 : nil
                        }
                        .font(.poppins(.Light, size: 12))
                        .offset(y:20)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .opacity(isLoadingView ? 0 : 1)
                        
                    }
                    .shimmerView(isLoading: $isLoadingView)


                }
            }
        }
        
    }
    
    var avtarView: some View {
        AsyncImage(url: URL(string: Constants.imageBaseURL200 +  (movieReview?.authorDetails?.avatarPath ?? ""))) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Text(movieReview?.author.prefix(1) ?? "-")
                .font(.poppins(.Black, size: 16))
                .foregroundColor(.black)
        }
        
        .frame(width:30,height: 30)
        .background(Color.AppGrayColor2)
        .clipShape(Circle())
    }
}

struct MovieReviewAuthorCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieReviewAuthorCardView(isLoadingView: .constant(true), movieReview: MovieReviewResponse.previewMovie.results.first!)
            .previewLayout(.sizeThatFits)
    }
}

