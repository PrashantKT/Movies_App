//
//  Genres.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation


// MARK: - Welcome
struct GenreResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable,Identifiable,Equatable {
    let id: Int
    let name: String
}
extension Genre {
    static let topTrending = Genre(id: -150, name: "Trending")
}
