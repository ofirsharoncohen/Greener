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
        
        self.navigationItem.leftBarButtonItem = LogOut;
        self.navigationItem.rightBarButtonItem = addNewPost;
        if(self.tabBarController?.selectedIndex  == 0)
        {
            self.navigationItem.title = "Greener";
        }
        else
        {
            self.navigationItem.title = Auth.auth().currentUser!.email
        }
        self.navigationItem.hidesBackButton = true;        // Do any additional setup after loading the view.
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
    }    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
