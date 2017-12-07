//
//  UserService.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 04/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation

class UserService {
    
    public func register(login: String, password: String) {
        let cryptoService = CryptoService();
        do {
            let salt = try cryptoService.randomSalt();
            let hash = try cryptoService.deriveKeyFromPassword(password: password, salt: salt);
            
            let user = User();
            user.login = login;
            let saltData = Data(bytes: salt, count: 30);
            user.salt = String(data: saltData, encoding: String.Encoding.utf8);
            user.hash = hash;
        } catch CryptoServiceError.prngFail {
            print("Failed to generate salt");
        } catch CryptoServiceError.derivationFail {
            print("PBKDF2 failed");
        } catch {
            print("Erreur inconnue");
        }
    }
}


