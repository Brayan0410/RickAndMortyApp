//
//  RepositoriesProtocols.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation
import Combine

protocol CharacterRepositoryProtocol {
    func fetchCharacters(page: Int, filters: CharacterFilters) async throws -> [Character]
    func fetchCharacter(by id: Int) async throws -> Character
}

protocol EpisodeRepositoryProtocol {
    func fetchEpisodes(by ids: [Int]) async throws -> [Episode]
}

struct CharacterFilters {
    var name: String?
    var status: String?
    var species: String?
}
