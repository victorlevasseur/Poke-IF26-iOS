//
//  PokemonsService.swift
//  Poke-IF26
//
//  Created by user134638 on 12/25/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class PokemonsService {
    
    private static var instance: PokemonsService? = nil
    
    public static func getInstance() -> PokemonsService {
        guard let existingInstance = instance else {
            let newInstance = PokemonsService()
            instance = newInstance
            return newInstance
        }
        return existingInstance
    }
    
    private init() {
        
    }
    
    /**
     * Get the pokemon data from the PokéAPI
     */
    public func fetchPokemon(pokemon: Pokemon) -> Single<FetchedPokemon> {
        let httpClient = HttpClientService.getInstance()
        
        return httpClient.getJson(path: "https://pokeapi.co/api/v2/pokemon/\(pokemon.pokemonId)")
            .flatMap({ (pokemonJson) in
                guard let sprites = pokemonJson["sprites"] else {
                    throw PokemonsError.noBitmap
                }
                guard let imageUrl = sprites["front_default"] else {
                    throw PokemonsError.noBitmap
                }
                
                return Single.zip(Single.just(pokemonJson), httpClient.getImage(path: imageUrl as! String))
                    .map({ (data) -> FetchedPokemon in
                        guard let name = data.0["name"] else {
                            throw PokemonsError.noName
                        }
                        
                        return FetchedPokemon(pokemon: pokemon, pokemonName: name as! String, pokemonBitmap: data.1)
                    })
            })
    }
    
    public func getNotCapturedPokemons() -> [Pokemon] {
        let pokemonDao = PokemonDao()
        return try! pokemonDao.getNotCapturedPokemons()
    }
    
    public func fetchNotCapturedPokemons() -> Single<[FetchedPokemon]> {
        let apiCalls = self.getNotCapturedPokemons()
            .map({ (pokemon) -> Observable<FetchedPokemon> in
                return self.fetchPokemon(pokemon: pokemon).asObservable()
            })
        return Observable.zip(apiCalls).asSingle()
    }
    
}

enum PokemonsError: Error {
    case noBitmap
    case noName
}
