//
//  MoviePagination.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 05/09/23.
//

import Foundation

struct MoviePagination {
    var isRequestingNewpage = false
    var currentPage = 1
    var isMoreRecordAvailable = true
    var task:Task<(),Never>?
    var lastRecord:Movie?
    
    mutating func reset() {
        isRequestingNewpage = false
        currentPage = 1
        isMoreRecordAvailable = true
        task?.cancel()
        task = nil
        lastRecord = nil
    }
}
