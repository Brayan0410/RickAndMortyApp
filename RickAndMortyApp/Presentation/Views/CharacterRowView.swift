//
//  CharacterRowView.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import SwiftUI

struct CharacterRowView: View {
    let character: Character
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: character.image) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(character.name)
                    .font(.headline)
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(character.status)
                    .font(.caption)
                    .foregroundColor(character.status == "Alive" ? .green : .red)
            }
        }
        .padding(.vertical, 6)
    }
}
