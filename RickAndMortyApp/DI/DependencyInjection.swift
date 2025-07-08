//
//  DependencyInjection.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation
import Swinject

final class DependencyInjection {
    static let shared = DependencyInjection()
    let container = Container()
    
    private init() {
        registerDependencies()
    }
    
    private func registerDependencies() {
        container.register(CharacterRepositoryProtocol.self) { _ in CharacterRepository() }
        container.register(EpisodeRepositoryProtocol.self) { _ in EpisodeRepository() }
    }
}
