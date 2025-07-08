//
//  RickAndMortyAppTests.swift
//  RickAndMortyAppTests
//
//  Created by Brayan Gutierrez Juarez on 07/07/25.
//

import XCTest
@testable import RickAndMortyApp

final class CharacterListViewModelTests: XCTestCase {
    
    @MainActor
    func testFilteringByStatus() async {
        let viewModel = CharacterListViewModel(characterRepository: MockCharacterRepository())

        viewModel.selectedStatus = "Alive"
        await viewModel.loadCharacters()

        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick")
    }
}
