//
//  ViewController.swift
//  Greener
//
//  Created by Studio on 01/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var segueId:String
        if Auth.auth().currentUser != nil{
            segueId = "StartAppSegue"
        }else {
            segueId = "toLoginSegue"
        }
        sleep(2) //time to display logo
        performSegue(withIdentifier: segueId, sender: self)
    }

}

