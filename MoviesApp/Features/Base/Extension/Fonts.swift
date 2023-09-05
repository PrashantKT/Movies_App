//
//  Fonts.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import Foundation

import SwiftUI

enum Popppins:String {
    case Regular = "Poppins-Regular"
    case Bold = "Poppins-Bold"
    case Black = "Poppins-Black"
    case Medium = "Poppins-Medium"
    case SemiBold = "Poppins-SemiBold"
    case Light = "Poppins-Light"

}

extension Font {
    static func poppins(_ type:Popppins,size:CGFloat) -> Font {
        return .custom(type.rawValue, size: size)
    }
}
