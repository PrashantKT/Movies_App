//
//  View.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import SwiftUI

extension View {
    
    var screenWidth:CGFloat {
        UIScreen.main.bounds.width
    }
    
    var screenHeight:CGFloat {
        UIScreen.main.bounds.height
    }
}

extension View  {
    func readSize(onChange :@escaping(CGSize) -> Void) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: proxy.size)
            }
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
        }
    }
}
