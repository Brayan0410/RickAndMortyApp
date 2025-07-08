//
//  MapView.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 23.6345, longitude: -102.5528), // Centro de México
        span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
    )

    @State private var characters: [Character] = []

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: characters) { character in
            MapAnnotation(coordinate: LocationSimulator.simulatedCoordinate(for: character.id)) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                    Text(character.name)
                        .font(.caption)
                        .fixedSize()
                }
            }
        }
        .onAppear {
            Task { await loadCharacters() }
        }
        .navigationTitle("Mapa de Personajes")
    }

    func loadCharacters() async {
        let ids = Array(FavoritesManager.shared.favoriteIDs)

        guard !ids.isEmpty else {
            print("No hay personajes favoritos")
            return
        }

        let repository = DependencyInjection.shared.container.resolve(CharacterRepositoryProtocol.self)!
        var results: [Character] = []

        for id in ids {
            if let character = try? await repository.fetchCharacter(by: id) {
                results.append(character)
            }
        }

        await MainActor.run {
            self.characters = results
        }
    }
}
