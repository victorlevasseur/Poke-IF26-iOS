//
//  PokedexTableViewController.swift
//  Poke-IF26
//
//  Created by user134638 on 12/13/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PokedexTableViewController: UITableViewController {

    //TODO : get this from PokemonDao
    var ownedPokemons : [Pokemon] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();

        self.loadOwnedPokemons();
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    public func loadOwnedPokemons(pokemonDao: PokemonDao = PokemonDao()) {
        do {
            try self.ownedPokemons = pokemonDao.getPokemonsCapturedByUser(user: currentUser!);
        } catch {
            let alertController = UIAlertController(title: "Pokedex", message: "Erreur de base de donnée", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Reload the pokemons when the tab controller is switched to this view.
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownedPokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let httpClientService = HttpClientService.getInstance()
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        cell.textLabel!.text = "Chargement..."
        cell.detailTextLabel?.text = ""
        
        let id = indexPath.row;
        print("https://pokeapi.co/api/v2/pokemon/\(ownedPokemons[id].id!)");
        let _ = httpClientService.getJson(path: "https://pokeapi.co/api/v2/pokemon/\(ownedPokemons[id].id!)")
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                    case .success(let pokemon):
                        let name = pokemon["name"] as? String
                        cell.textLabel!.text = name
                    case .error(let error):
                        print("\(error)")
                }
            }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
