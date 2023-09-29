//
//  TabbarView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 28/09/23.
//

import SwiftUI

struct TabbarView: View {
    
    @EnvironmentObject  var viewModel:MainViewModel
    var body: some View {
        TabView(selection: $viewModel.currentTab) {
                HomeView()
                .tabItem {

                    Label(Tab.home.tabTitle, systemImage: "house")

                }
                .tag(Tab.home)
           FavoriteView()
                .tabItem {
                    Image("BookmarkIcon")
                        .renderingMode(.template)
                    
                    Text(Tab.fav.tabTitle)

                }
                .tag(Tab.fav)
                .badge(viewModel.badgeCount)

        }
        .tint( Color.pink)
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
            .environmentObject(MainViewModel())
    }
}
