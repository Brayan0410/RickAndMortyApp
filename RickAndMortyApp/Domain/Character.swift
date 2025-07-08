//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation

struct Character: Identifiable, Codable, Equatable {

    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: URL
    let locationName: String
    let episodeIDs: [Int]
}
