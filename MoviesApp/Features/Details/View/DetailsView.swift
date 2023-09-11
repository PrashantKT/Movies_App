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
                    
                    LazyVStack(alignment: .leading,pinnedViews: .sectionHeaders) {
                        Section {
                              
                            switch vm.currentTab {
                                
                            case 0:
                                aboutMovieSection
                                    .tag(DetailSectionTab.aboutMovie.rawValue)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding()
                                    .readSize(onChange: { size in
                                        vm.tabSize[DetailSectionTab.aboutMovie.rawValue] = size
                                        
                                    })
                                
                            case 1:

                                reviewView
                                    .tag(DetailSectionTab.reviews.rawValue)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .readSize(onChange: { size in
                                        vm.tabSize[DetailSectionTab.reviews.rawValue] = size
                                    })
                              
                            case 2:

                                castView
                                    .tag(DetailSectionTab.cast.rawValue)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding()
                                    .readSize(onChange: { size in
                                        vm.tabSize[DetailSectionTab.cast.rawValue] = size
                                    })
                            default:
                                EmptyView()
                                
                            }
                          
                        } header: {
                            SectionSelectionView(selectedGenre: $vm.currentTab, genre: DetailSectionTab.displayAsGenre, nameSpace: namespace)
                                .background(Color.AppBackgroundColor)
                        }
                       
                        
                    }
                }
                .padding(.top,screenWidth * 0.2)
            }
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
        .onAppear {
            vm.fetchMoveDetails(id: movie.id)
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
        VStack {
            Text(vm.movieCastAndCrew?.cast.first?.name ?? "")
                .font(.poppins(.Medium, size: 16))
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
