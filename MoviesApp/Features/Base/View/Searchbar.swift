//
//  Searchbar.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 05/09/23.
//

import Foundation

import SwiftUI

struct Searchbar: View {
    @Binding var searchText:String
    @FocusState private var searchFocus:Bool
    var body: some View {
        TextField("Search", text: $searchText)
            .font(.poppins(.SemiBold, size: 16))
            .autocorrectionDisabled()
            .overlay(alignment:.trailing) {
                if !searchText.isEmpty {
                    Image.cancelIcon
                        .contentShape(Rectangle())
                        .onTapGesture {
                            searchText = ""
                            searchFocus = false
                        }
                } else {
                    Image.SearchIcon
                        .allowsHitTesting(false)
                }
            }
            .focused($searchFocus)
            .onSubmit {
                searchFocus = false
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.AppGrayColor1)
            )
    }
}

struct Searchbar_Previews: PreviewProvider {
    static var previews: some View {
        Searchbar(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
