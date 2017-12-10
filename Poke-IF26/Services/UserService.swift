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
        let userDao = UserDao();

        do {
            let salt = try cryptoService.randomSalt();
            let hash = try cryptoService.deriveKeyFromPassword(password: password, salt: salt);
            
            let saltData = Data(bytes: salt, count: 30);
            let user = User(id: nil, login: login, hash: hash, salt: saltData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)));
            
            let _ = try userDao.create(user: user);
        } catch CryptoServiceError.prngFail {
            print("Failed to generate salt");
        } catch CryptoServiceError.derivationFail {
            print("PBKDF2 failed");
        }
        catch UserDaoError.insertFail {
            print("Failed to insert user");
        }
        catch {
            print("Erreur inconnue");
        }
    }
    
    public func login(login: String, password: String) -> Bool {
        let cryptoService = CryptoService();
        let userDao = UserDao();
        
        do {
            let user = try userDao.loadByLogin(login: login)
            
            let saltData = Data(base64Encoded: user.salt!, options: NSData.Base64DecodingOptions(rawValue: 0))!;
            let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: saltData.count);
            let stream = OutputStream(toBuffer: buffer, capacity: saltData.count);
            stream.open();
            saltData.withUnsafeBytes({ (p: UnsafePointer<UInt8>) -> Void in
                stream.write(p, maxLength: saltData.count)
            })
            stream.close();

            let hash = try cryptoService.deriveKeyFromPassword(password: password, salt: UnsafePointer<UInt8>(buffer))
            if hash == user.hash {
                return true;
            }
        } catch {
            print("Erreur inconnue")
        }
        
        return false;
    }
}


