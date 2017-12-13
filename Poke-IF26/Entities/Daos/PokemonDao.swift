//
//  PokemonDao.swift
//  Poke-IF26
//
//  Created by user134638 on 12/13/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation

class PokemonDao {
    public func getNotCapturedPokemons() throws -> [Pokemon] {
        do {
            let db = DatabaseService.getInstance().getDb();
            return try db.selectFrom("pokemons", whereExpr: "captured_by_user == ?", parameters: [nil], block: Pokemon.init)
        } catch {
            throw PokemonDaoError.selectFail
        }
    }
    
    public func getPokemonsCapturedByUser(user: User) throws -> [Pokemon] {
        do {
            let db = DatabaseService.getInstance().getDb();
            return try db.selectFrom("pokemons", whereExpr: "captured_by_user == ?", parameters: [user.id], block: Pokemon.init)
        } catch {
            throw PokemonDaoError.selectFail
        }
    }
}

enum PokemonDaoError: Error {
    case selectFail
}
