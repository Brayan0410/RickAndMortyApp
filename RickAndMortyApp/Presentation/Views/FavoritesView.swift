//
//  FavoritesView.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel = FavoritesViewModel()

    var body: some View {
        Group {
            if !viewModel.isAuthenticated {
                VStack(spacing: 20) {
                    Text("Acceso a favoritos protegido")
                        .font(.title2)
                    if let error = viewModel.errorMessage {
                        Text(error).foregroundColor(.red)
                    }
                    Button("Autenticarse") {
                        Task { await viewModel.authenticate() }
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                List(viewModel.favoriteCharacters) { character in
                    NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))) {
                        CharacterRowView(character: character)
                    }
                }
                .navigationTitle("Favoritos")
                .refreshable {
                    await viewModel.loadFavorites()
                }
            }
        }
        .padding()
    }
}
