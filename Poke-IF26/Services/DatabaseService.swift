//
//  DatabaseService.swift
//  Poke-IF26
//
//  Created by LEVASSEUR Victor on 01/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import Squeal

class DatabaseService {
    
    private static var instance: DatabaseService? = nil
    
    private var db: Database
    
    private init() throws {
        if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dbPath = documentsPathURL.appendingPathComponent("pokeif26.db")
            self.db = try Database(path: dbPath.absoluteString)
        } else {
            throw DatabaseInitializationError.documentsPathNotFound
        }
    }
    
    static func getInstance() -> DatabaseService {
        if (instance == nil) {
            do {
                try instance = DatabaseService()
            } catch {
                fatalError("Can't initialize the database!")
            }
        }
        return instance!
    }
    
    func getDb() -> Database {
        return self.db
    }
}

enum DatabaseInitializationError: Error {
    case documentsPathNotFound
}
