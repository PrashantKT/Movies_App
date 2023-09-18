//
//  ErrorView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 15/09/23.
//

import SwiftUI

struct ErrorView: View {
    var height:CGFloat? = nil
    var width:CGFloat? = nil
    var msg:String = "Something went wrong"
    
    @State private var animate = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: animate ?  12 : 8)
            .fill(  Color.red.gradient)
            .opacity(animate ? 1 : 0.9)
            .frame(width:width, height: height)
            .overlay {
                VStack(spacing:14) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .scaleEffect(animate ? 1.2 : 1)
                    Text(msg)
                        .font(.poppins(.Medium, size: 14))
                        .foregroundColor(.white)
                }
            }
            .onAppear {
                withAnimation(.linear(duration: 0.7).repeatForever()) {
                    animate = true
                }
            }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(height: 200,width:200)
    }
}
