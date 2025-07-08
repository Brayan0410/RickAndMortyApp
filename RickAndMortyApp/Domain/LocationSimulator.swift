//
//  LocationSimulator.swift
//  RickAndMortyApp
//
//  Created by Brayan Gutierrez Juarez on 08/07/25.
//

import CoreLocation

struct LocationSimulator {
    static func simulatedCoordinate(for characterID: Int) -> CLLocationCoordinate2D {
        let latitude = 19.0 + Double(characterID % 10) * 0.1
        let longitude = -99.0 - Double(characterID % 10) * 0.1
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
