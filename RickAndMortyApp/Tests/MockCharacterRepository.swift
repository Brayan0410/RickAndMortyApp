//
//  MockCharacterRepository.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation
@testable import RickAndMortyApp

class MockCharacterRepository: CharacterRepositoryProtocol {
    func fetchCharacters(page: Int, filters: CharacterFilters) async throws -> [Character] {
        let sample = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", gender: "Male", image: URL(string: "https://...")!, locationName: "Earth", episodeIDs: [1, 2]),
            Character(id: 2, name: "Morty", status: "Dead", species: "Human", gender: "Male", image: URL(string: "https://...")!, locationName: "Earth", episodeIDs: [3])
        ]

        if let status = filters.status {
            return sample.filter { $0.status == status }
        }

        return sample
    }

    func fetchCharacter(by id: Int) async throws -> Character {
        return Character(id: id, name: "Test", status: "Alive", species: "Test", gender: "Test", image: URL(string: "https://...")!, locationName: "Earth", episodeIDs: [])
    }
}

