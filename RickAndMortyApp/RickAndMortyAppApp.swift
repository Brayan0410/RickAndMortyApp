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
    @StateObject private var favoritesManager = FavoritesManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(favoritesManager)  // <-- Aquí lo agregas
        }
    }
}

