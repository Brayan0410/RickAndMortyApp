//
//  FavoritesManager.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation

class FavoritesManager: ObservableObject {
    @Published private(set) var favoriteIDs: Set<Int> = []

    private let key = "favorite_character_ids"
    
    init() {
        loadFavorites()
    }
    
    private func loadFavorites() {
        if let saved = UserDefaults.standard.array(forKey: key) as? [Int] {
            favoriteIDs = Set(saved)
        }
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: key)
    }
    
    func toggleFavorite(id: Int) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
        saveFavorites()
    }
    
    func isFavorite(id: Int) -> Bool {
        favoriteIDs.contains(id)
    }
}
