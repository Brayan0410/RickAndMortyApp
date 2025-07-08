//
//  EpisodeDTO.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation

struct EpisodeDTO: Codable {
    let id: Int
    let name: String
    let episode: String
    
    func toDomain() -> Episode {
        return Episode(id: id, name: name, episode: episode)
    }
}
