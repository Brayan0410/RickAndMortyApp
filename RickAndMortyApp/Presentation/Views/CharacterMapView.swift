//
//  CharacterMapView.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import SwiftUI
import MapKit

struct CharacterMapView: View {
    let character: Character
    
    @State private var region: MKCoordinateRegion
    
    init(character: Character) {
        self.character = character
        let coordinate = LocationSimulator.simulatedCoordinate(for: character.id)
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        )
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [character]) { character in
            MapAnnotation(coordinate: LocationSimulator.simulatedCoordinate(for: character.id)) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                    Text(character.name)
                        .font(.caption)
                        .fixedSize()
                }
            }
        }
        .navigationTitle("Ubicación de \(character.name)")
        .edgesIgnoringSafeArea(.bottom)
    }
}
