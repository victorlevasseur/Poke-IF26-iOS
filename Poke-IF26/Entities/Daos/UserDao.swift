//
//  UserDao.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 07/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation

class UserDao {
    public func create(user: User) throws -> Int64 {
        do {
            let db = DatabaseService.getInstance().getDb();
            return try db.insertInto(
                "users",
                values: [
                    "login": user.login,
                    "hash": user.hash,
                    "salt": user.salt,
                    ]
            )
        } catch {
            throw UserDaoError.insertFail
        }
    }
    
    public func loadByLogin(login: String) throws -> User {
        do {
            let db = DatabaseService.getInstance().getDb();
            //injection sql?
            let users = try db.selectFrom("users", whereExpr:"login == ?", parameters: [login], block: User.init)
            if (users.count != 1) {
                throw UserDaoError.notFound
            }
            return users[0]
        } catch {
            throw UserDaoError.selectFail
        }
    }
}

enum UserDaoError: Error {
    case insertFail
    case selectFail
    case notFound
}
