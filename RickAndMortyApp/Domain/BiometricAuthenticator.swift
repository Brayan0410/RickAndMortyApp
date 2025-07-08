//
//  BiometricAuthenticator.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import LocalAuthentication

class BiometricAuthenticator {
    enum AuthError: Error {
        case failed
        case canceled
        case notAvailable
    }

    func authenticateUser(reason: String = "Accede a tus favoritos") async throws {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            throw AuthError.notAvailable
        }

        try await withCheckedThrowingContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                if success {
                    continuation.resume()
                } else {
                    continuation.resume(throwing: AuthError.failed)
                }
            }
        }
    }
}
