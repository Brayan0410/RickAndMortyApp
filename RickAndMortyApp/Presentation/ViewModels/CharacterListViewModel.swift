//
//  CharacterListViewModel.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation
import Combine

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    @Published var selectedStatus: String = "All"
    @Published var selectedSpecies: String = ""
    
    private let characterRepository: CharacterRepositoryProtocol
    private var currentPage = 1
    private var canLoadMorePages = true
    private var isLoadingPage = false
    
    init(characterRepository: CharacterRepositoryProtocol = DependencyInjection.shared.container.resolve(CharacterRepositoryProtocol.self)!) {
        self.characterRepository = characterRepository
    }
    
    func loadCharacters() async {
        currentPage = 1
        canLoadMorePages = true
        characters = []
        await loadNextPage()
    }

    func loadNextPage() async {
        guard !isLoadingPage && canLoadMorePages else { return }
        isLoadingPage = true
        isLoading = true
        errorMessage = nil

        do {
            let filters = CharacterFilters(
                name: searchText.isEmpty ? nil : searchText,
                status: selectedStatus == "All" ? nil : selectedStatus,
                species: selectedSpecies.isEmpty ? nil : selectedSpecies
            )
            
            let fetched = try await characterRepository.fetchCharacters(page: currentPage, filters: filters)
            characters.append(contentsOf: fetched)
            canLoadMorePages = !fetched.isEmpty
            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
        isLoadingPage = false
    }
    
    func refreshCharacters() async {
        await loadCharacters()
    }
}
