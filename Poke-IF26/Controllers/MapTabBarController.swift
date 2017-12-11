//
//  MapTabBarController.swift
//  Poke-IF26
//
//  Created by user134638 on 12/11/17.
//  Copyright © 2017 GIRARD GUITTARD Antoine / LEVASSEUR Victor. All rights reserved.
//

import FontAwesomeSwift
import UIKit

class MapTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.items![0].setFAIcon(icon: .FAMap, textColor: .black, selectedTextColor: .red)
        self.tabBar.items![1].setFAIcon(icon: .FAList, textColor: .black, selectedTextColor: .red)
        self.tabBar.items![2].setFAIcon(icon: .FAUser, textColor: .black, selectedTextColor: .red)
        
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

}
