//
//  BiometricAuthenticator.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import Foundation
import LocalAuthentication

class BiometricAuthenticator {
    func authenticateUser() async throws {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            throw error ?? NSError(domain: "Biometría no disponible", code: -1)
        }

        let reason = "Accede a tus personajes favoritos"

        let success = try await context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason
        )

        if !success {
            throw NSError(domain: "Autenticación fallida", code: -1)
        }
    }
}
