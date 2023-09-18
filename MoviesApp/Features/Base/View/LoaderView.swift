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

struct SectionBasedLoaderView : View {
    var width:CGFloat? = nil
    var height:CGFloat? = nil
    @State private var animate = false
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color(uiColor: UIColor.systemGray2))
            .frame(width: width,height: height)
            .opacity(animate ? 1 : 0.7)
            .transition(.opacity)
            .overlay {
//                ProgressView()
//                    .frame(width: 55,height: 55)
//                    .tint(Color.white)
            }
            .onAppear {
                withAnimation(.linear(duration: 0.3).repeatForever()) {
                    animate = true
                }
            }
    }
}

struct SectionBasedLoaderView_Preview:PreviewProvider {
    static var previews: some View {
        SectionBasedLoaderView(width: 300,height: 300)
    }
}
