//
//  TabBarViewController.swift
//  Greener
//
//  Created by Studio on 21/02/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import Firebase

class TabBarViewController: UITabBarController {
    
    @IBOutlet weak var LogOut: UIBarButtonItem!
    @IBOutlet weak var addNewPost: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.items?[0].title = "Greener";
        tabBar.items?[1].title = Auth.auth().currentUser!.email;
        
        self.navigationItem.leftBarButtonItem = LogOut;
        self.navigationItem.rightBarButtonItem = addNewPost;
        self.navigationItem.hidesBackButton = true;
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        title = tabBar.selectedItem?.title;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        title = tabBar.selectedItem?.title;
    }
    @IBAction func LogOut(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "NewPostSegue"){
            let vc:InfoViewController = segue.destination as! InfoViewController
            vc.isNew = true
            vc.userId = Auth.auth().currentUser!.email
        }
    }
    
}
