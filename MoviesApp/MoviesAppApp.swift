//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    @StateObject var mainVM = MainViewModel()
    var body: some Scene {
        WindowGroup {
            TabbarView()
                .environmentObject(mainVM)
        }
    }
}
