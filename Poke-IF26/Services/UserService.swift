//
//  UserService.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 04/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation

/**
 * Service managing users and the connected user.
 */
class UserService {
    
    private static var instance: UserService? = nil
        
    private init() {
        
    }
    
    public static func getInstance() -> UserService {
        guard let userService = instance else {
            let newInstance = UserService()
            instance = newInstance
            return newInstance
        }
        return userService
    }
    
    /**
     * Register an user.
     */
    public func register(login: String, password: String) throws {
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
            throw UserServiceError.registerFail
        } catch CryptoServiceError.derivationFail {
            print("PBKDF2 failed");
            throw UserServiceError.registerFail
        }
        catch UserDaoError.insertFail {
            print("Failed to insert user");
            throw UserServiceError.registerFail
        }
        catch {
            print("Erreur inconnue");
            throw UserServiceError.registerFail
        }
    }
    
    /**
     * Attempt a login with the login and password pair.
     * @return the connected user.
     * throws UserServiceError.alreadyLoggedIn if an user is already logged in.
     * throws UserServiceError.invalidCredentials if the user credentials are invalid.
     */
    public func login(login: String, password: String) throws -> User {
        if currentUser != nil {
            throw UserServiceError.alreadyLoggedIn
        }
        
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
                return user
            } else {
                throw UserServiceError.invalidCredentials
            }
        } catch {
            throw UserServiceError.invalidCredentials
        }
    }
    
    /**
     * Log out.
     * throws UserServiceError.notLoggedIn if no users were connected
     */
    public func logout() throws {
        if currentUser == nil {
            throw UserServiceError.notLoggedIn
        }
        currentUser = nil
    }
    }

enum UserServiceError: Error {
    case registerFail
    case invalidCredentials
    case alreadyLoggedIn
    case notLoggedIn
}
