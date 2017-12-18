//
//  HttpClientService.swift
//  Poke-IF26
//
//  Created by user134638 on 12/14/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
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
    
    public func get(path: String) -> Single<[String:AnyObject]> {
        return Single.create { single in
            self.client.get(url: path)
                .end(done: { response in
                    if response.basicStatus == .ok {
                        do {
                            guard let responseData = response.data else {
                                single(.error(HttpError.jsonError))
                                return
                            }
                            let json = try JSONSerialization.jsonObject(with: responseData) as! [String:AnyObject]
                            single(.success(json))
                        } catch {
                            single(.error(HttpError.jsonError))
                        }
                    } else {
                        single(.error(HttpError.responseError(status: response.basicStatus)))
                    }
                }, onError: { error in
                    single(.error(HttpError.unknownError))
                })
            
            return Disposables.create()
        }
    }
    
    static func getInstance() -> HttpClientService {
        if instance == nil {
            instance = HttpClientService()
        }
        return instance!
    }
}

enum HttpError: Error {
    case unknownError
    case responseError(status: Response.BasicResponseType)
    case jsonError
}
