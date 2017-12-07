//
//  DatabaseService.swift
//  Poke-IF26
//
//  Created by LEVASSEUR Victor on 01/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation

class DatabaseService {
    
    private static var instance: DatabaseService? = nil
    
    private var db: Database
    
    init() throws {
        self.db = try Database(path: "poke")
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
