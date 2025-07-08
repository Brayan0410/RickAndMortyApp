//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation

struct Episode: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let episode: String 
}
