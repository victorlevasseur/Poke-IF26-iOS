//
//  Pokemon.swift
//  Poke-IF26
//
//  Created by user134638 on 12/13/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import Squeal

//Note: the Pokemon from the PokemonKit library is called PKMPokemon
struct Pokemon {
    let id: Int64?
    let pokemonId: Int64
    let capturedByUserId: Int64?
    let latitude: Double
    let longitude: Double
    
    init(row: Statement) {
        id = row.int64Value("id")
        pokemonId = row.int64Value("pokemon_id")!
        capturedByUserId = row.int64Value("captured_by_user_id")
        latitude = row.doubleValue("latitude")!
        longitude = row.doubleValue("longitude")!
    }
    
    init(id: Int64?, pokemonId: Int64, capturedByUserId: Int64?, latitude: Double, longitude: Double) {
        self.id = id;
        self.pokemonId = pokemonId;
        self.capturedByUserId = capturedByUserId;
        self.latitude = latitude
        self.longitude = longitude
    }
}
