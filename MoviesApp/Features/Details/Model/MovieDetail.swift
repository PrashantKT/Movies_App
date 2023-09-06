//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 06/09/23.
//

import Foundation


struct MovieDetail: Codable {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollection
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

extension MovieDetail {
    
    private static let defaultData =
    """
    {
      "adult": false,
      "backdrop_path": "/A9IY3j3Hwf4Q8Q9w5QxSQPYSvCu.jpg",
      "belongs_to_collection": {
        "id": 131,
        "name": "Three Colors Collection",
        "poster_path": "/rVdd23QuT5rHX7lZvuAkRRUkeCZ.jpg",
        "backdrop_path": "/AeHExfHIl70SZCea907KfEoSkfJ.jpg"
      },
      "budget": 0,
      "genres": [
        {
          "id": 18,
          "name": "Drama"
        },
        {
          "id": 9648,
          "name": "Mystery"
        },
        {
          "id": 10749,
          "name": "Romance"
        }
      ],
      "homepage": "",
      "id": 110,
      "imdb_id": "tt0111495",
      "original_language": "fr",
      "original_title": "Trois couleurs : Rouge",
      "overview": "Valentine, a student model in Geneva, struggles with a possessive boyfriend and a troubled family. When she runs over a dog, she discovers that its owner, a retired judge, is illegally wiretapping and eavesdropping on his neighbors' phone calls. Although Valentine is outraged, she develops a strange bond with the judge – and as the two become closer, she finds herself caught in the middle of events that could change her life.",
      "popularity": 17.575,
      "poster_path": "/JHmsBiX1tjCKqAul1lzC20WcAW.jpg",
      "production_companies": [
        {
          "id": 38,
          "logo_path": "/qMi10Y3HnR7BQRqMC4ch7qZ6HN4.png",
          "name": "Zespół Filmowy TOR",
          "origin_country": "PL"
        },
        {
          "id": 183,
          "logo_path": null,
          "name": "Le Studio Canal+",
          "origin_country": "FR"
        },
        {
          "id": 591,
          "logo_path": "/q5I5RDwMEiqoNmfaJgd2LraEOJY.png",
          "name": "France 3 Cinéma",
          "origin_country": "FR"
        },
        {
          "id": 1245,
          "logo_path": "/suKdkPTtHn0DzGYmrXCA506dJON.png",
          "name": "TSR",
          "origin_country": "CH"
        },
        {
          "id": 14,
          "logo_path": "/m6AHu84oZQxvq7n1rsvMNJIAsMu.png",
          "name": "Miramax",
          "origin_country": "US"
        }
      ],
      "production_countries": [
        {
          "iso_3166_1": "FR",
          "name": "France"
        },
        {
          "iso_3166_1": "PL",
          "name": "Poland"
        },
        {
          "iso_3166_1": "CH",
          "name": "Switzerland"
        }
      ],
      "release_date": "1994-05-12",
      "revenue": 0,
      "runtime": 100,
      "spoken_languages": [
        {
          "english_name": "French",
          "iso_639_1": "fr",
          "name": "Français"
        }
      ],
      "status": "Released",
      "tagline": "",
      "title": "Three Colors: Red",
      "video": false,
      "vote_average": 7.955,
      "vote_count": 1209
    }

    """
    
    static let previewMovie = try! JSONDecoder().decode(MovieDetail.self, from:defaultData.data(using: .utf8)!)
}



