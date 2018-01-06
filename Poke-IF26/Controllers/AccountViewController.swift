//
//  AccountViewController.swift
//  Poke-IF26
//
//  Created by user134638 on 1/6/18.
//  Copyright © 2018 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

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
    
    func errorAlert() {
        let alertController = UIAlertController(title: "Gestion du compte", message: "Une erreur est survenue", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func successAlert() {
        let alertController = UIAlertController(title: "Gestion du compte", message: "Les changements ont été effectués", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func onPassClick(_ sender: Any) {
        let alertController = UIAlertController(title: "Changement de mdp", message: "Entrez le nouveau mot de passe", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Mot de passe"
        }
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Mode de passe (confirmation)"
        }
        
        let cancelAction = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.default, handler: nil);
        let confirmAction = UIAlertAction(title: "Confirmer", style: UIAlertActionStyle.default) { (_) in
            if alertController.textFields![0].text == alertController.textFields![1].text {
                do {
                    try UserService.getInstance().changePassword(user: currentUser!, password: alertController.textFields![0].text!);
                } catch {
                    print("here");
                    self.errorAlert();
                    return;
                }
                self.successAlert();
            } else {
                print("or here");
                self.errorAlert();
            }
        }
        
        alertController.addAction(confirmAction);
        alertController.addAction(cancelAction);
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onIdClick(_ sender: Any) {
    }
    
    @IBAction func onDeleteClick(_ sender: Any) {
    }
}
