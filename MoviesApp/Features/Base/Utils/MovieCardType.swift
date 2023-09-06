//
//  File.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import Foundation

enum MovieCardType {
    case poster
    case grid
}

extension MovieCardType {
    var widthPercentage : CGFloat {
        switch self {
        case .poster:
            return 0.45
        case .grid:
            return 0.25
        }
    }
    
    var heightPercentage : CGFloat {
        switch self {
        case .poster:
            return 0.7
        case .grid:
            return 0.30
        }
    }
}

extension MovieCardType {
    var baseURL:String {
        switch self {
        case .poster:
            return Constants.imageBaseURL500
        case .grid:
            return Constants.imageBaseURL200
            
        }
    }
}
