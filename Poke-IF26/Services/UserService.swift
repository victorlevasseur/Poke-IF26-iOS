//
//  UserService.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 04/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import CommonCrypto

class UserService {
    public func register(username: String, password: String) {
        let cryptoService = CryptoService();
        let salt = cryptoService.randomSalt();
        let hash = cryptoService.deriveKeyFromPassword();
        
        
    }
}

enum UserServiceError: Error {
    case prngFail
}
