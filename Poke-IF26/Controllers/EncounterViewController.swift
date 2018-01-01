//
//  EncounterViewController.swift
//  Poke-IF26
//
//  Created by user134638 on 1/1/18.
//  Copyright © 2018 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import Foundation
import UIKit

class EncounterViewController: UIViewController {
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let encounteredPokemon = pokemon else {
            fatalError("EncounterViewController must be initialized with a pokemon!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
