//
//  GenreView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import SwiftUI

struct SectionSelectionView: View {
    @Binding var selectedGenre:Int
    var genre:[Genre]
    var nameSpace:Namespace.ID
    @Namespace var animation
    var body: some View {
        
        ScrollView(.horizontal,showsIndicators: false) {
            HStack {
                ForEach(genre) { genre in
                    
                    Text(genre.name)
                        .frame(height:45)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedGenre = genre.id
                            }
                        }
                        .padding(.horizontal)
                        .overlay(alignment:.bottom) {
                            if genre.id == selectedGenre {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.AppGrayColor2)
                                    .frame(height:3)
                                    .opacity(genre.id == selectedGenre ? 1 : 0)
                                    .matchedGeometryEffect(id: "animation_id", in: animation)
                            }
                        }
                }
            }
        }
    }
}

struct GenreView_Previews: PreviewProvider {
    @Namespace static var nameSpace
    static var previews: some View {
        SectionSelectionView(selectedGenre: .constant(2), genre: [.init(id: 1, name: "54352dfgdsg"),.init(id: 2, name: "testgsgsergs2"),.init(id: 3, name: "54352dfgdsg"),.init(id: 4, name: "testgsgsergs2"),.init(id: 5, name: "54352dfgdsg"),.init(id: 6, name: "testgsgsergs2")], nameSpace:nameSpace )
    }
}
