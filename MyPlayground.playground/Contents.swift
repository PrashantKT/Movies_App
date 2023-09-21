import UIKit

var greeting = "Hello, playground"



extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {

    func queryString() -> String? {
        var urlComponents = URLComponents(url: URL(string:"www.google.com")!, resolvingAgainstBaseURL: false)

        
        let queryItems = self.map{
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        
        urlComponents?.queryItems = queryItems
       return  urlComponents?.query

    }
}


let values = ["include_video":false,"genre_id":5,"lang" : "eng"] as [String : Any]

print(values.queryString())


//
//  MovieReviews.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 06/09/23.
//

import Foundation

struct MovieReviewResponse: Codable {
    let id, page: Int
    let results: [MovieReview]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieReview
struct MovieReview: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name, username, avatarPath: String
    let rating: Int

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}

extension MovieReviewResponse {
    
     static let defaultData =
    """
    
    {
      "id": 110,
      "page": 1,
      "results": [
        {
          "author": "Filipe Manuel Neto",
          "author_details": {
            "name": "Filipe Manuel Neto",
            "username": "FilipeManuelNeto",
            "avatar_path": "/nidqITf735x9xxHfncXkT9BmOQ7.png",
            "rating": 7
          },
          "content": "",
          "created_at": "2023-02-10T18:50:51.792Z",
          "id": "63e6920ba3d02700d333178f",
          "updated_at": "2023-02-10T18:50:51.927Z",
          "url": "https://www.themoviedb.org/review/63e6920ba3d02700d333178f"
        },
        {
          "author": "CinemaSerf",
          "author_details": {
            "name": "CinemaSerf",
            "username": "Geronimo1967",
            "avatar_path": "/1kks3YnVkpyQxzw36CObFPvhL5f.jpg",
            "rating": 7
          },
          "content": "ersonality.",
          "created_at": "2023-05-15T09:29:03.003Z",
          "id": "6461fb5e8c44b90119cb5586",
          "updated_at": "2023-05-15T09:29:03.079Z",
          "url": "https://www.themoviedb.org/review/6461fb5e8c44b90119cb5586"
        }
      ],
      "total_pages": 1,
      "total_results": 2
    }
    
    """
    
    
    
}


do {
    let previewMovie = try JSONDecoder().decode(MovieReviewResponse.self, from:MovieReviewResponse.defaultData.data(using: .utf8)!)

}
catch {
    print(error)
}


let t = Array(repeating: UUID().uuidString, count: 5).joined(separator: "\n")
print(t)
