//
//  DetailsView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 06/09/23.
//

import SwiftUI

struct DetailsView: View {
    
    @Binding var movie:Movie
    @StateObject  var vm = MovieDetailViewModel(movieService: MovieService())
    @Namespace var namespace
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            VStack {
                MovieDetailsHeaderView(movie: $movie)
                VStack {
                    tagView
                    SectionSelectionView(selectedGenre: $vm.currentTab, genre: DetailSectionTab.displayAsGenre, nameSpace: namespace)
                        .padding(.bottom,6)
                        .background(Color.AppBackgroundColor)
                        
                    Divider()
                    
                    switch vm.currentTab {
                    case 0:
                        aboutMovieSection
                            .tag(DetailSectionTab.aboutMovie.rawValue)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                    case 1:
                        reviewView
                            .tag(DetailSectionTab.reviews.rawValue)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case 2:
                        castView
                            .tag(DetailSectionTab.cast.rawValue)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                    default:
                        EmptyView()
                        
                    }
                    
                }
                .padding(.top,screenWidth * 0.2)
            }
        }
        .background(Color.AppBackgroundColor.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .navigationTitle("Details")
        .preferredColorScheme(.dark)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.bold)
                        .tint(Color.white)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image("BookmarkIcon")
                        .renderingMode(.template)
                        .tint(Color.white)
                }

            }
        }
        .task {
            vm.fetchMoveDetails(id: movie.id)
        }
        .modifier(LoaderView(isLoading: $vm.isLoading))

        
    }
    
    var tagView: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            
            HStack {
                Label(vm.movieDetailsResponse?.releaseDate ?? "-", image: "CalendarIcon")
                Divider()
                    .frame(height: 20)
                Label("\(vm.movieDetailsResponse?.runtime ?? 0) Minutes", image: "ClockIcon")
                Divider()
                    .frame(height: 20)
                Label(vm.fetchGenres(), image: "GenreIcon")
                    .lineLimit(1)
            }
        }
        .padding(.horizontal,20)
        
        .font(.poppins(.Regular, size: 12))
        .foregroundColor(Color.AppGrayColor2)
    }
    
    @ViewBuilder var aboutMovieSection : some View {
        VStack {
            Text(vm.movieDetailsResponse?.overview ?? "")
                .font(.poppins(.Medium, size: 16))
        }
    }
    
    @ViewBuilder var reviewView : some View {
        if let movieReview = vm.movieRevies?.results {
            ForEach(movieReview) { review in
                MovieReviewAuthorCardView(movieReview: review)
                    .padding(.horizontal,4)
                    .padding(.vertical,6)

                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 15))
                    .listRowSeparator(.hidden)
            }
            .padding([.horizontal,.bottom])
        } else {
            Text("No Reviews for this Movie")
                .font(.poppins(.Medium, size: 14))
                .padding(.top,50)
        }
    }
    
    @ViewBuilder var castView : some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
            ForEach(vm.movieCastAndCrew?.cast ?? []) { cast in
                CastCardView(cast: cast)
            }
        }
    }
}

struct MovieDetailsHeaderView : View {
    @Binding var movie:Movie
    var body: some View {
        ZStack(alignment:.bottomLeading) {
            GeometryReader {proxy in
                let size = proxy.frame(in: .global)
                MovieImageLoader(movie: movie, cardType: .poster,imageType:.backdrop)
                    .clipped()
                    .frame(width: size.width,height:size.height)
                    .overlay {
                        HStack {
                            Image(systemName: "star")
                            Text(String(format: "%0.1f", (movie.voteAverage ?? 0)))
                        }
                        .font(.poppins(.Bold, size: 14))
                        .kerning(0.12)
                        .foregroundColor(Color.orange)
                        .padding(.horizontal,8)
                        .padding(.vertical,2)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottomTrailing)
                        .padding([.trailing,.bottom],6)

                    }
                
                
            }
            .frame(height:screenHeight * 0.35)
            HStack(spacing:15) {
                MovieImageLoader(movie: movie,cardType: .grid)
                    .frame(width: screenWidth * 0.3,height: screenWidth * 0.4)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: Color.black.opacity(0.2), radius: 5,x: 5,y: 5)
                    .shadow(color: Color.white.opacity(0.2), radius: 5,x: -5,y:-5)
                
                Text(movie.title)
                    .font(.poppins(.SemiBold, size: 18))
                    .offset(y:30)

            }
            .padding()
            .offset(y:screenWidth * 0.2)
            
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    @Namespace static var nameSpace
    static var previews: some View {
        
        NavigationStack {
            DetailsView(movie: .constant(Movie.previewMovie))
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Movie.previewMovie.title)
        }
    }
}
