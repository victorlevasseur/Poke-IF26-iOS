//
//  Pokemon.swift
//  Poke-IF26
//
//  Created by user134638 on 12/13/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import Squeal

/**
 * Represents a pokemon.
 */
struct Pokemon {
    let id: Int64?
    let pokemonId: Int64
    let capturedByUserId: Int64?
    let latitude: Double
    let longitude: Double
    let capturability: Double
    
    /**
     * Initialize a pokemon from a database row
     */
    init(row: Statement) {
        self.id = row.int64Value("id")
        self.pokemonId = row.int64Value("pokemon_id")!
        self.capturedByUserId = row.int64Value("captured_by_user_id")
        self.latitude = row.doubleValue("latitude")!
        self.longitude = row.doubleValue("longitude")!
        self.capturability = row.doubleValue("capturability")!
    }
    
    /**
     * Initialize a pokemon from its API id, latitude, longitude and capturability.
     * The pokemon is not captured.
     */
    init(pokemonId: Int64, latitude: Double, longitude: Double, capturability: Double) {
        self.id = nil
        self.pokemonId = pokemonId
        self.latitude = latitude
        self.longitude = longitude
        self.capturability = capturability
        self.capturedByUserId = nil
    }
    
    /**
     * Initialize a pokemon from all its fields.
     */
    init(id: Int64?, pokemonId: Int64, capturedByUserId: Int64?, latitude: Double, longitude: Double, capturability: Double) {
        self.id = id;
        self.pokemonId = pokemonId;
        self.capturedByUserId = capturedByUserId;
        self.latitude = latitude
        self.longitude = longitude
        self.capturability = capturability
    }
}
