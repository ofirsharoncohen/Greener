//
//  SignupViewController.swift
//  Greener
//
//  Created by Studio on 01/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var Email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterUser(_ sender: Any) {
       //showTextInputPrompt(withMessage: "Email:") {  [weak self] userPressedOK, email in
       // guard let strongSelf = self else { return }
        //let passwordConfirm = ConfirmPassword.text
        //let password = Password.text
        let email = Email.text
        
        if Email.text == "" {
            let alert = UIAlertController(title: "error", message: "email can't be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
          return
        }
            
    
        if Password.text == "" {
            let alert = UIAlertController(title: "error", message: "password can't be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
          }
        
        if(Password.text != ConfirmPassword.text) {
          let alert = UIAlertController(title: "error", message: "error confirm password", preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
            return
        }
            // [START create_user]
        Auth.auth().createUser(withEmail: email!, password: Password.text!) { authResult, error in
              // [START_EXCLUDE]
             // strongSelf.hideSpinner {
                guard let user = authResult?.user, error == nil else {
                    let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                  return
                }
                print("\(user.email!) created")
                self.navigationController?.popViewController(animated: true)
              }
              // [END_EXCLUDE]
            }
            // [END create_user]
          }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


