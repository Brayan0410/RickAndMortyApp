//
//  EpisodeViewStateManager.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation

class EpisodeViewStateManager: ObservableObject {
    private let key = "seen_episode_ids"
    @Published private(set) var seenEpisodeIDs: Set<Int> = []

    static let shared = EpisodeViewStateManager()

    private init() {
        load()
    }

    private func load() {
        if let saved = UserDefaults.standard.array(forKey: key) as? [Int] {
            seenEpisodeIDs = Set(saved)
        }
    }

    private func save() {
        UserDefaults.standard.set(Array(seenEpisodeIDs), forKey: key)
    }

    func isEpisodeSeen(id: Int) -> Bool {
        seenEpisodeIDs.contains(id)
    }

    func toggleEpisodeSeen(id: Int) {
        if seenEpisodeIDs.contains(id) {
            seenEpisodeIDs.remove(id)
        } else {
            seenEpisodeIDs.insert(id)
        }
        save()
    }
}

