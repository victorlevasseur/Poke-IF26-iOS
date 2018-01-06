//
//  PokemonDao.swift
//  Poke-IF26
//
//  Created by user134638 on 12/13/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation

class PokemonDao {
    public func create(pokemon: Pokemon) throws -> Int64 {
        do {
            let db = DatabaseService.getInstance().getDb();
            return try db.insertInto(
                "pokemons",
                values: [
                    "pokemon_id": pokemon.pokemonId,
                    "captured_by_user": pokemon.capturedByUserId,
                    "latitude": pokemon.latitude,
                    "longitude": pokemon.longitude,
                    "capturability": pokemon.capturability
                ]
            )
        } catch {
            throw UserDaoError.insertFail
        }
    }
    
    public func capture(user: User, pokemon: Pokemon) throws {
        do {
            let db = DatabaseService.getInstance().getDb();
            try db.update(
                "pokemons",
                setExpr: "captured_by_user = ?",
                whereExpr: "id = ?",
                parameters: [user.id, pokemon.id]
            )
        } catch {
            throw PokemonDaoError.updateFail
        }
    }
    
    public func deleteNotCapturedPokemons() {
        let db = DatabaseService.getInstance().getDb()
        try! db.deleteFrom("pokemons", whereExpr: "captured_by_user IS NULL", parameters: [])
    }
    
    public func getNotCapturedPokemons() throws -> [Pokemon] {
        do {
            let db = DatabaseService.getInstance().getDb();
            return try db.selectFrom("pokemons", whereExpr: "captured_by_user IS NULL", parameters: [], block: Pokemon.init)
        } catch {
            throw PokemonDaoError.selectFail
        }
    }
    
    public func getPokemonsCapturedByUser(user: User) throws -> [Pokemon] {
        do {
            let db = DatabaseService.getInstance().getDb();
            return try db.selectFrom("pokemons", whereExpr: "captured_by_user = ?", parameters: [user.id], block: Pokemon.init)
        } catch {
            throw PokemonDaoError.selectFail
        }
    }
}

enum PokemonDaoError: Error {
    case insertFail
    case selectFail
    case updateFail
}
