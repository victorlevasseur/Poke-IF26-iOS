//
//  CryptoService.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 04/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation

//PBKDF2 == https://stackoverflow.com/a/40342300
class CryptoService {
    public func randomSalt() throws -> UnsafePointer<UInt8> {
        let saltBytePointer = UnsafeMutableRawPointer.allocate(bytes: 30, alignedTo: 1)
        let successRng = SecRandomCopyBytes(kSecRandomDefault, 30, saltBytePointer);
        if(successRng != errSecSuccess) {
            throw CryptoServiceError.prngFail
        }
        
        return UnsafePointer<UInt8>(saltBytePointer.assumingMemoryBound(to: UInt8.self))
    }
    
    public func deriveKeyFromPassword(password: String, salt: UnsafePointer<UInt8>) throws -> String {
        let passswordCString = (password as NSString).utf8String;
        let derivedKey   = [UInt8](repeating:0, count:256)
        
        let derivationStatus = CCKeyDerivationPBKDF(
            CCPBKDFAlgorithm(kCCPBKDF2),
            passswordCString,
            password.count,
            salt,
            30,
            CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
            100,
            UnsafeMutablePointer<UInt8>(mutating: derivedKey),
            derivedKey.count
        )
        
        if (derivationStatus != 0) {
            throw CryptoServiceError.derivationFail
        }
        
        return String(bytes: derivedKey, encoding: String.Encoding.utf8)!;
    }
}

enum CryptoServiceError: Error {
    case prngFail
    case derivationFail
}
