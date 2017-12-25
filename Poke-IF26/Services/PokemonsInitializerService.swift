//
//  PokemonsInitializerService.swift
//  Poke-IF26
//
//  Created by user134638 on 12/25/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import os.log

class PokemonsInitializerService {
    
    private static var instance: PokemonsInitializerService? = nil
    
    private static var initialPokemons: [Pokemon] = [
        Pokemon(pokemonId: 2, latitude: 48.269042, longitude: 4.066038, capturability: 0.9),
        Pokemon(pokemonId: 6, latitude: 48.269301, longitude: 4.065839, capturability: 0.7),
        Pokemon(pokemonId: 14, latitude: 48.269502, longitude: 4.066899, capturability: 0.4),
        Pokemon(pokemonId: 8, latitude: 48.105809, longitude: 5.130293, capturability: 0.8),
    ]
    
    public static func getInstance() -> PokemonsInitializerService {
        guard let existingInstance = instance else {
            let newInstance = PokemonsInitializerService()
            instance = newInstance
            return newInstance
        }
        return existingInstance
    }
    
    private init() {
        
    }
    
    public func initializePokemons() {
        let pokemonDao = PokemonDao()
        
        // First delete all the not captured pokemons so that they will be recreated.
        pokemonDao.deleteNotCapturedPokemons()
        
        // Try to recreate each pokemon
        PokemonsInitializerService.initialPokemons.forEach { pokemon in
            let pokemonInfo = "pokemonId = \(pokemon.pokemonId), latitude = \(pokemon.latitude), longitude = \(pokemon.longitude)"
            do {
                let _ = try pokemonDao.create(pokemon: pokemon)
                os_log("Added pokemon in DB (%@)", pokemonInfo)
            } catch {
                os_log("Already existing pokemon in DB (%@)", pokemonInfo)
            }
        }
    }
    
}
