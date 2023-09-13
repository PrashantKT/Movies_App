//
//  LoaderView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 13/09/23.
//

import SwiftUI


struct LoaderView:ViewModifier {
    @Binding var isLoading:Bool
    
    func body(content: Content) -> some View {
        content.overlay {
            if isLoading {
                ZStack {
                    Color.black.opacity(0.7)
                        .ignoresSafeArea()
                    ProgressView()
                        .frame(width: 55,height: 55)
                }
            }
        }
    }
}
