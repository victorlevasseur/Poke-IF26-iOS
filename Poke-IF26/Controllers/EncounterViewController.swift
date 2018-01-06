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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var capturabilityView: UIProgressView!
    @IBOutlet weak var captureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let encounteredPokemon = pokemon else {
            fatalError("EncounterViewController must be initialized with a pokemon!")
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let _ = PokemonsService.getInstance().fetchPokemon(pokemon: encounteredPokemon)
            .subscribe(onSuccess: { (fetchedPokemon) in
                // Update the UI with the pokemon info.
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                self.imageView.image = fetchedPokemon.pokemonBitmap
                self.nameView.text = fetchedPokemon.pokemonName
                self.capturabilityView.progress = Float(fetchedPokemon.pokemon.capturability)
                self.captureButton.isHidden = false
            }) { (err) in
                // Can't fetch the pokemon, pop back to the map.
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.navigationController?.popViewController(animated: true)
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCaptureClick(_ sender: Any) {
        let pokemonDao = PokemonDao();
        do {
            try pokemonDao.capture(user: currentUser!, pokemon: self.pokemon!)
        } catch {
            let alertController = UIAlertController(title: "Capture", message: "Impossible de mettre à jour le pokédex", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        let alertController = UIAlertController(title: "Capture", message: "La capture est un succès", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        let mapStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let controller = mapStoryboard.instantiateInitialViewController();
        present(controller!, animated: true, completion: nil)

    }
    
}
