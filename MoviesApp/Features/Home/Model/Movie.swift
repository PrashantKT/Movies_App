//
//  Movie.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import Foundation


// MARK: - Welcome
struct MovieResponse: Codable {
    let page: Int
    var results: [Movie]?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable,Identifiable,Equatable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath:String?
    var releaseDate, title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie:Hashable {}

extension Movie {
    var imagePosterSize:String {
        if let posterPath {
            return Constants.imageBaseURL500 + posterPath
        } else {
            return ""
        }
    }
    
    var imageSmallGridSize:String {
        if let posterPath {
            return Constants.imageBaseURL200 + posterPath
        } else {
            return ""
        }
    }
    
    func fetchBaseURL(cardType:MovieCardType,imageType:MovieImageType) -> String {
        switch imageType {
        case .backdrop:
            return Constants.imageBaseURL + (backdropPath ?? posterPath ?? "")
        case .poster:
            switch cardType {
            case .poster:
                return imagePosterSize
            case .grid:
                return imageSmallGridSize
            }
        }
    }
}

extension Movie {
    enum MovieImageType {
        case poster
        case backdrop
    }
}

extension Movie {
    
    private static let defaultData =
    """
    {
          "adult": false,
          "backdrop_path": "/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg",
          "genre_ids": [
            53,
            80
          ],
          "id": 680,
          "original_language": "en",
          "original_title": "Pulp Fiction",
          "overview": "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.",
          "popularity": 67.834,
          "poster_path": "/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg",
          "release_date": "1994-09-10",
          "title": "Pulp Fiction",
          "video": false,
          "vote_average": 8.5,
          "vote_count": 25779
        }
    """
    
    static let previewMovie = try! JSONDecoder().decode(Movie.self, from:defaultData.data(using: .utf8)!)
}
