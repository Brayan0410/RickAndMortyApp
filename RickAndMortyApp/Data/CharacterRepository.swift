//
//  CharacterRepository.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation

class CharacterRepository: CharacterRepositoryProtocol {
    
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    
    func fetchCharacters(page: Int, filters: CharacterFilters) async throws -> [Character] {
        var urlComponents = URLComponents(string: baseURL)!
        var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        
        if let name = filters.name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        if let status = filters.status, !status.isEmpty {
            queryItems.append(URLQueryItem(name: "status", value: status))
        }
        if let species = filters.species, !species.isEmpty {
            queryItems.append(URLQueryItem(name: "species", value: species))
        }
        
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
        case 200:
            let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            return apiResponse.results.map { $0.toDomain() }
            
        case 404:
            return []
            
        default:
            throw URLError(.badServerResponse)
        }
    }
    func fetchCharacter(by id: Int) async throws -> Character {
        let urlString = "\(baseURL)/\(id)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let dto = try JSONDecoder().decode(CharacterDTO.self, from: data)
        return dto.toDomain()
    }
}
