//
//  FavoritesViewModel.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation
import LocalAuthentication

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var favoriteCharacters: [Character] = []

    private let favoritesManager: FavoritesManager
    private let biometricAuthenticator = BiometricAuthenticator()
    private let characterRepository: CharacterRepositoryProtocol

    init(
        favoritesManager: FavoritesManager = .shared,  
        characterRepository: CharacterRepositoryProtocol = DependencyInjection.shared.container.resolve(CharacterRepositoryProtocol.self)!
    ) {
        self.favoritesManager = favoritesManager
        self.characterRepository = characterRepository
    }

    func authenticate() async {
        do {
            try await biometricAuthenticator.authenticateUser()
            isAuthenticated = true
            await loadFavorites()
        } catch {
            errorMessage = "Autenticación fallida o cancelada"
            isAuthenticated = false
        }
    }

    func loadFavorites() async {
        let ids = Array(favoritesManager.favoriteIDs)
        var chars: [Character] = []
        for id in ids {
            do {
                let character = try await characterRepository.fetchCharacter(by: id)
                chars.append(character)
            } catch {
                print("Error cargando personaje con id \(id): \(error)")
            }
        }
        favoriteCharacters = chars
    }
}
