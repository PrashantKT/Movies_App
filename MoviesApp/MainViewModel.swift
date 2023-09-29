//
//  TabbarViewModel.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 28/09/23.
//

import SwiftUI

class MainViewModel:ObservableObject {
    
    @Published var currentTab = Tab.home
    @Published private (set) var badgeCount = 0
    @Published var favRepo = FavRepoImpl()
    
    init() {
    }
    
    func incrementBadgeCount() {
        badgeCount += 1
    }
    func resetBadgeCount() {
        badgeCount = 0
    }
    
    func addRemoveFav(movie:Movie) {
        if !favRepo.isFavExits(movie: movie) {
            Task {
                try? await favRepo.storeFavrite(movie:movie)
                await MainActor.run {
                    self.incrementBadgeCount()

                }
            }
        } else {
            Task {
                try? await favRepo.removeFavorite(movie:movie)
                await MainActor.run {
                    self.incrementBadgeCount()

                }
            }
        }
        
    }
    
    
}

