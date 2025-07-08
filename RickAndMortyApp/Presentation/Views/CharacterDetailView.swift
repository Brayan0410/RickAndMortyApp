//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel
    @State private var showMap = false
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: viewModel.character.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .clipped()
                .cornerRadius(10)

                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack {
                        Text("Estado:")
                        Text(viewModel.character.status)
                            .foregroundColor(viewModel.character.status == "Alive" ? .green : .red)
                    }

                    Text("Especie: \(viewModel.character.species)")
                    Text("Género: \(viewModel.character.gender)")
                    Text("Ubicación: \(viewModel.character.locationName)")
                }
                .padding(.horizontal)

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Episodios")
                        .font(.title2)
                        .bold()

                    if viewModel.isLoading {
                        ProgressView()
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                    } else {
                        ForEach(viewModel.episodes) { episode in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(episode.name)
                                        .font(.body)
                                    Text(episode.episode)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Button(action: {
                                }) {
                                    Image(systemName: "eye")
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding(.horizontal)

                Divider()

                HStack(spacing: 16) {
                    Button(action: {
                        favoritesManager.toggleFavorite(id: viewModel.character.id)
                    }) {
                        Label(
                            favoritesManager.isFavorite(id: viewModel.character.id) ? "Favorito" : "Agregar a favoritos",
                            systemImage: favoritesManager.isFavorite(id: viewModel.character.id) ? "heart.fill" : "heart"
                        )
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }

                    Button(action: {
                        showMap = true
                    }) {
                        Label("Ver en mapa", systemImage: "map")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .sheet(isPresented: $showMap) {
                    NavigationView {
                        CharacterMapView(character: viewModel.character)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle(viewModel.character.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadEpisodes()
        }
    }
}
