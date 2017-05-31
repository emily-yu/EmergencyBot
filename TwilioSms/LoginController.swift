//
//  LoginController.swift
//  TwilioSms
//
//  Created by Emily on 5/29/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import Foundation
import Firebase

class LoginController: UIViewController {
    
    var ref:FIRDatabaseReference!
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func login(_ sender: Any) {
        if self.email.text == "" || self.password.text == "" {

            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                    
                    print("You have successfully logged in")
                
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "navbar")
                    self.present(vc!, animated: true, completion: nil)
                    
                }
                else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }

    }
}
