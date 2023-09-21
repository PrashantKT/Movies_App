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
    var cornerRadius:CGFloat = 12
    var body: some View {
        ZStack{
            Color.black.cornerRadius(cornerRadius)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color(uiColor: UIColor.systemGray2))
                .opacity(animate ? 1 : 0.7)

        }
        .frame(width: width,height: height)
        .transition(.opacity)
        .onAppear {
            withAnimation(.linear(duration: 0.4).repeatForever()) {
                animate = true
            }
        }
    }
}

struct SectionBasedLoaderView_Preview:PreviewProvider {
    static var previews: some View {
        VStack(alignment:.leading,spacing: 5) {
            HStack {
                Circle()
                    .frame(width: 45)
                    .padding(12)

                    .shimmerView(isLoading: .constant(true))
                VStack(alignment:.leading,spacing: 10) {
                    Text("Hello How are you")
                        .shimmerView(isLoading: .constant(true))
                    Text("test")
                        .shimmerView(isLoading: .constant(true),width: 80)
                }
                
            }
        }
        .padding()

//        SectionBasedLoaderView(width: 300,height: 300)
    }
}

struct ShimmerView: ViewModifier {
    @Binding var isLoadig:Bool
    var width:CGFloat?
    var height:CGFloat?
    func body(content: Content) -> some View {
        content.overlay {
            if isLoadig {
                GeometryReader { proxy in
                    let cornerRadius = min(proxy.size.width,proxy.size.height)
                    SectionBasedLoaderView(width: width,height: height,cornerRadius:proxy.size.width == proxy.size.height ?  cornerRadius / 2 : 12)
                }
            }
        }
    }
    
}

extension View {
    
    func shimmerView(isLoading:Binding<Bool>,width:CGFloat? = nil , height:CGFloat? = nil) -> some View {
        
        self.frame(width:width, height:height).padding(2).modifier(ShimmerView(isLoadig: isLoading,width: width))
        
        
    }
    
}

