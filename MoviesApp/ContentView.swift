//
//  ContentView.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 01/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var appState = AppState()
    var body: some View {
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
