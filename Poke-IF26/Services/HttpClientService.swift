//
//  HttpClientService.swift
//  Poke-IF26
//
//  Created by user134638 on 12/14/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import SwiftClient

class HttpClientService {
    private let client: Client = Client()
        .baseUrl(url: "http://pokeapi.co/api/v2")
    
    static private var instance: HttpClientService? = nil
    
    private init() {
        
    }
    
    public func getClient() -> Client {
        return self.client
    }
    
    static func getInstance() -> HttpClientService {
        if instance == nil {
            instance = HttpClientService()
        }
        return instance!
    }
}
