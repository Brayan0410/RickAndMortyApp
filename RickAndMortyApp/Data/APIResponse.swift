//
//  APIResponse.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation

struct APIResponse: Codable {
    let info: PageInfo
    let results: [CharacterDTO]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: LocationDTO
    let episode: [String]
}

struct LocationDTO: Codable {
    let name: String
}

extension CharacterDTO {
    func toDomain() -> Character {
        let episodeIDs: [Int] = episode.compactMap {
            Int($0.split(separator: "/").last ?? "")
        }
        return Character(
            id: id,
            name: name,
            status: status,
            species: species,
            gender: gender,
            image: URL(string: image)!,
            locationName: location.name,
            episodeIDs: episodeIDs
        )
    }
}
