//
//  User.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 04/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import SharkORM

class User: SRKObject {
    dynamic var login: String?
    dynamic var hash: String?
    dynamic var salt: String?
}
