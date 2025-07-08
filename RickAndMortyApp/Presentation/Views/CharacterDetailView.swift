//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel

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

                // Información básica
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
                        // TODO: marcar como favorito
                    }) {
                        Label("Favorito", systemImage: "heart")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }

                    Button(action: {
                        // TODO: ir al mapa
                    }) {
                        Label("Ver en mapa", systemImage: "map")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
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
