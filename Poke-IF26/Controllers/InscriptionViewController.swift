//
//  InscriptionViewController.swift
//  Poke-IF26
//
//  Created by GIRARD GUITTARD Antoine on 07/12/2017.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import UIKit

class InscriptionViewController: UIViewController {

    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var passwordConfirmInput: UITextField!
    
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
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Inscription", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)

    }

    @IBAction func onRegisterClick(_ sender: Any) {
        let userService = UserService.getInstance()
        
        let login = loginInput.text!
        let password = passwordInput.text!
        let passwordConfirm = passwordConfirmInput.text!
        
        if password != passwordConfirm {
            displayAlert(message: "Les messages ne correspondent pas")
            return
        }
        
        do {
            try userService.register(login: login, password: password)
            displayAlert(message: "Inscription réussie")
        } catch {
            displayAlert(message: "Erreur lors de l'inscription")
        }
    }
    
}
