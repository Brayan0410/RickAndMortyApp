//
//  EpisodeRepository.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation

class EpisodeRepository: EpisodeRepositoryProtocol {
    private let baseURL = "https://rickandmortyapi.com/api/episode/"

    func fetchEpisodes(by ids: [Int]) async throws -> [Episode] {
        guard !ids.isEmpty else { return [] }

        let urlString = baseURL + ids.map { "\($0)" }.joined(separator: ",")
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()

        if ids.count == 1 {
            let episode = try decoder.decode(EpisodeDTO.self, from: data)
            return [episode.toDomain()]
        } else {
            let episodes = try decoder.decode([EpisodeDTO].self, from: data)
            return episodes.map { $0.toDomain() }
        }
    }
}
