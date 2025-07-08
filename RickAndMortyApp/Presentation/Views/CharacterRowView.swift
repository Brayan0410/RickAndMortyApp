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
        HStack {
            AsyncImage(url: character.image) { phase in
                if let image = phase.image {
                    image.resizable().scaledToFill()
                } else if phase.error != nil {
                    Color.red // Error
                } else {
                    ProgressView()
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray.opacity(0.4), lineWidth: 1))

            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)

                HStack {
                    Circle()
                        .fill(color(for: character.status))
                        .frame(width: 8, height: 8)
                    Text("\(character.status) - \(character.species)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 6)
    }
    func color(for status: String) -> Color {
        switch status {
        case "Alive":
            return .green
        case "Dead":
            return .red
        default:
            return .gray
        }
    }
}
