//
//  Favorite.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 28/09/23.
//

import SwiftUI
import Foundation



enum FavoriteRepError:Error {
    case encodeFail
    case savedFail
    case otherIssue
}


actor FavRepoImpl {
    
    nonisolated private func isFileExits(at url:URL) -> Bool {
        return FileManager.default.fileExists(atPath: url.path())
    }
    
    private  func createFavinDocumentFolder() {
        if !isFileExits(at: favoriteFolder()) {
           try? FileManager.default.createDirectory(at: favoriteFolder(), withIntermediateDirectories: true)
        }
    }
    
    nonisolated private func favoriteFolder() -> URL {
        let document = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let folderPath = document.appending(path: "Favorites")
        return folderPath
    }
    
    nonisolated func isFavExits(movie:Movie)  ->Bool{
        let movieFolder = favoriteFolder().appending(path: "\(movie.id)")
        return isFileExits(at: movieFolder)
    }
    
    private func saveData(data:Data,of movie:Movie) throws {
        let movieFolder = favoriteFolder().appending(path: "\(movie.id)")
        do {
            try data.write(to: movieFolder)
        } catch{
            throw FavoriteRepError.savedFail
        }
    }
    
    func storeFavrite(movie:Movie) async throws {
        createFavinDocumentFolder()
        guard  !isFavExits(movie: movie) else {
            return
        }
        guard let movieData = try? JSONEncoder().encode(movie) else{
            throw FavoriteRepError.encodeFail
        }
        try saveData(data: movieData, of: movie)
        
    }
    
    func readFavorite() async -> [Movie] {
        var movies = [Movie]()
        let movieFolder = favoriteFolder()
        
        if let allItems = try? FileManager.default.contentsOfDirectory(at: movieFolder, includingPropertiesForKeys: nil) {

            for item in allItems {
                if let data = try? Data(contentsOf: item), let movie = try? JSONDecoder().decode(Movie.self, from: data) {
                    movies.append(movie)
                }
            }
        }

        return movies
    }
    
    func removeFavorite(movie:Movie) async throws{
        guard isFavExits(movie: movie) else {
            return
        }
        let movieFolder = favoriteFolder().appending(path: "\(movie.id)")
        try FileManager.default.removeItem(at: movieFolder)
    }
}


