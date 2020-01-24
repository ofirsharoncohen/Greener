//
//  LoginViewController.swift
//  Greener
//
//  Created by Studio on 01/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginUserBtn(_ sender: Any) {
        loginButton.isEnabled = false
        guard let email = self.userTextField.text, let password = self.passwordTextField.text else {
            let alert = UIAlertController(title: "error", message: "email/password can't be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            loginButton.isEnabled = true
            return
        }
        // [START headless_email_auth]
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            // [START_EXCLUDE]
            if error != nil {
                let alert = UIAlertController(title: "error", message: error!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.loginButton.isEnabled = true
                return
            }
            else
            {
                self.performSegue(withIdentifier: "finishLoginSegue", sender: self)
            }
            
        }
        // [END_EXCLUDE]
    }
    // [END headless_email_auth]
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
