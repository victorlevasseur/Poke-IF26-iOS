//
//  ConnexionViewController.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 04/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import UIKit

class ConnexionViewController: UIViewController {

    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onConnectClick(_ sender: Any) {
        let userService = UserService.getInstance();
        
        let login = loginInput.text!;
        let password = passwordInput.text!;
        
        do {
            currentUser = try userService.login(login: login, password: password)
            
            let mapStoryboard = UIStoryboard(name: "Map", bundle: nil)
            let controller = mapStoryboard.instantiateInitialViewController();
            present(controller!, animated: true, completion: nil)
        } catch {
            let alertController = UIAlertController(title: "Connexion", message: "Mauvais mot de passe", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
