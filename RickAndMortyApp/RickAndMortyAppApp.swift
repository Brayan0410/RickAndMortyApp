//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 07/07/25.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    let persistenceController = PersistenceController.shared
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(favoritesManager)  
        }
    }
}

