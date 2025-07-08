//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 07/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CharacterListView()
                .tabItem {
                    Label("Personajes", systemImage: "person.3.fill")
                }

            NavigationView {
                FavoritesView()
            }
            .tabItem {
                Label("Favoritos", systemImage: "heart.fill")
            }

            NavigationView {
                MapView()
            }
            .tabItem {
                Label("Mapa", systemImage: "map.fill")
            }
        }
    }
}
