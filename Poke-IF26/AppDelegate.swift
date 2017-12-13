//
//  AppDelegate.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 01/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import GoogleMaps
import Squeal
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let AppSchema = Schema(identifier:"users") { schema in
            // Version 1:
            schema.version(1) { v1 in
                v1.createTable("users") { users in
                    users.primaryKey("id")
                    users.column("login", type:.Text, constraints:["NOT NULL"])
                    users.column("hash", type:.Text, constraints:["NOT NULL"])
                    users.column("salt", type:.Text, constraints:["NOT NULL"])
                }
            }
            
            // Version 2
            schema.version(2) { v2 in
                v2.createTable("pokemons") { pokemons in
                    pokemons.primaryKey("id")
                    pokemons.column("pokemon_id", type: .Integer, constraints: ["NOT NULL"])
                    pokemons.column("captured_by_user", type: .Integer, constraints: [])
                    pokemons.column("latitude", type: .Real, constraints: ["NOT NULL"])
                    pokemons.column("longitude", type: .Real, constraints: ["NOT NULL"])
                }
            }
            
            // Version 3
            schema.version(3) { v3 in
                v3.alterTable("users") { users in
                    users.alterColumn("login", renameTo: nil, changeTypeTo: nil, setConstraints: ["NOT NULL", "UNIQUE"])
                }
            }
        }
        
        let db = DatabaseService.getInstance().getDb();
        
        // Migrate to the latest version:
        do {
            let _ = try AppSchema.migrate(db)
        } catch {
            print("Failed migration")
        }
        
        GMSServices.provideAPIKey("AIzaSyC9_jPwnxWV3zrbRfauyE2jw7ooZPTNJhU")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

