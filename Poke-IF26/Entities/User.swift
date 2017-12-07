//
//  User.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 04/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation

struct User {
    let id: Int64?
    let login: String?
    let hash: String?
    let salt: String?
    
    init(row: Statement) {
        id = row.int64Value("id")
        login = row.stringValue("login")
        hash = row.stringValue("hash")
        salt = row.stringValue("salt")
    }
    
    init(id: Int64?, login: String?, hash: String?, salt: String?) {
        self.id = id
        self.login = login
        self.hash = hash
        self.salt = salt
    }
}
