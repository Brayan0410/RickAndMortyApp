//
//  CharacterDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation

@MainActor
class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character
    @Published var episodes: [Episode] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let episodeRepository: EpisodeRepositoryProtocol

    init(
        character: Character,
        episodeRepository: EpisodeRepositoryProtocol = DependencyInjection.shared.container.resolve(EpisodeRepositoryProtocol.self)!
    ) {
        self.character = character
        self.episodeRepository = episodeRepository
    }

    func loadEpisodes() async {
        guard !character.episodeIDs.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            episodes = try await episodeRepository.fetchEpisodes(by: character.episodeIDs)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
