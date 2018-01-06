//
//  FetchedPokemon.swift
//  Poke-IF26
//
//  Created by user134638 on 12/25/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import UIKit

class FetchedPokemon {
    private var _pokemonName: String
    private var _pokemonBitmap: UIImage
    private var _pokemon: Pokemon
    
    public var pokemonName: String {
        get {
            return self._pokemonName
        }
    }
    
    public var pokemonBitmap: UIImage {
        get {
            return self._pokemonBitmap
        }
    }
    
    public var pokemon: Pokemon {
        get {
            return self._pokemon
        }
    }
    
    public init(pokemon: Pokemon, pokemonName: String, pokemonBitmap: UIImage) {
        self._pokemon = pokemon
        self._pokemonName = pokemonName
        self._pokemonBitmap = pokemonBitmap
    }
}
