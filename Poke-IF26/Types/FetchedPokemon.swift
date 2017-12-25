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
    
    public init(pokemonName: String, pokemonBitmap: UIImage) {
        self._pokemonName = pokemonName
        self._pokemonBitmap = pokemonBitmap
    }
}
