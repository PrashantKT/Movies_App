//
//  Colors.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import SwiftUI


extension Color {
    
    static var AppBackgroundColor : Color {
        return Color("AppBackgroundColor")
    }
    
    static var AppGrayColor1 : Color {
        return Color("AppGrayColor1")
    }
    
    static var AppGrayColor2 : Color {
        return Color("AppGrayColor2")
    }
}

public extension Color {

    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
