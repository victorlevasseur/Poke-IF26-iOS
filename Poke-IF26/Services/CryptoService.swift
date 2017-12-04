//
//  CryptoService.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 04/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import CommonCrypto

//PBKDF2 == https://stackoverflow.com/a/40342300
class CryptoService {
    public func randomSalt() -> UnsafePointer<UInt8> {
        let saltBytePointer = UnsafeMutableRawPointer.allocate(bytes: 30, alignedTo: 1)
        let successRng = SecRandomCopyBytes(kSecRandomDefault, 30, saltBytePointer);
        if(successRng != errSecSuccess) {
            throw UserServiceError.prngFail
        }
        
        return UnsafePointer<UInt8>(saltBytePointer.assumingMemoryBound(to: UInt8.self))
    }
    
    public func deriveKeyFromPassword() -> [UInt8]! {
        let passwordData = password.data(using:String.Encoding.utf8)!
        let derivedKey   = [UInt8](count:256, repeatedValue:0)
        
        let derivationStatus = CCKeyDerivationPBKDF(
            CCPBKDFAlgorithm(kCCPBKDF2),
            UnsafePointer<Int8>(passwordData.bytes),
            passwordData.length,
            salt,
            CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
            100,
            UnsafeMutablePointer<UInt8>(derivedKey),
            derivedKey.count
        )
        
        if (derivationStatus != 0) {
            print("Error: \(derivationStatus)")
            return nil;
        }
        
        return derivedKey
    }
}
