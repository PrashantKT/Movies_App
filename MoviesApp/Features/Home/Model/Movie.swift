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
    let posterPath:String
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

extension Movie {
    var imageURLString:String {
        return Constants.imageBaseURL500 + posterPath
    }
    
}

extension Movie {
    
    private static let defaultData =
    """
    {
          "adult": false,
          "backdrop_path": "/dIWwZW7dJJtqC6CgWzYkNVKIUm8.jpg",
          "genre_ids": [
            10749,
            16,
            18
          ],
          "id": 372058,
          "original_language": "ja",
          "original_title": "君の名は。",
          "overview": "High schoolers Mitsuha and Taki are complete strangers living separate lives. But one night, they suddenly switch places. Mitsuha wakes up in Taki’s body, and he in hers. This bizarre occurrence continues to happen randomly, and the two must adjust their lives around each other.",
          "popularity": 76.947,
          "poster_path": "/q719jXXEzOoYaps6babgKnONONX.jpg",
          "release_date": "2016-08-26",
          "title": "Your Name.",
          "video": false,
          "vote_average": 8.5,
          "vote_count": 10204
        }
    """
    
    static let previewMovie = try! JSONDecoder().decode(Movie.self, from:defaultData.data(using: .utf8)!)
}
