//
//  TabBarModel.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 28/09/23.
//

import Foundation

enum Tab:Hashable {
    case home
    case fav
    
    var tabTitle:String {
        switch self {
            
        case .home:
            return "Movies"
        case .fav:
           return "Favories"
        }
    }
}
