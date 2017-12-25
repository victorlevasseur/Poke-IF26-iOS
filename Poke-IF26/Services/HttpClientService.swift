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
import UIKit

class HttpClientService {
    private let client: Client = Client()
        .baseUrl(url: "http://pokeapi.co/api/v2")
    
    static private var instance: HttpClientService? = nil
    
    private init() {
        
    }
    
    public func getClient() -> Client {
        return self.client
    }
    
    public func getJson(path: String) -> Single<[String:AnyObject]> {
        return self.getRaw(path: path)
            .map({ (data: Data) -> [String:AnyObject] in
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as! [String:AnyObject]
                    return json
                } catch {
                    throw HttpError.jsonError
                }
            })
    }
    
    public func getImage(path: String) -> Single<UIImage> {
        return self.getRaw(path: path)
            .map({ (data: Data) -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw HttpError.imageError
                }
                return image
            })
    }
    
    public func getRaw(path: String) -> Single<Data> {
        return Single.create { single in
            self.client.get(url: path)
                .end(done: { response in
                    if response.basicStatus == .ok {
                        guard let responseData = response.data else {
                            single(.error(HttpError.noDataError))
                            return
                        }
                        single(.success(responseData))
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
    case noDataError
    case jsonError
    case imageError
}
