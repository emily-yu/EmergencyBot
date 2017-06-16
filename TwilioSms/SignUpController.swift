//
//  SignUpController.swift
//  TwilioSms
//
//  Created by Emily on 5/29/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import Foundation
import Firebase

class SignUpController: UIViewController {
    
    var ref: FIRDatabaseReference!
    
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func signup(_ sender: Any) {
        if email.text! == "" || password.text! == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else {
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                self.ref = FIRDatabase.database().reference()
                if error == nil {
                    // set user details
                    self.ref.child((user?.uid)!).setValue([
                        "emergencyMessage": "default",
                        "contacts": [
                            "0": "default"
                        ],
                        "emergencyContact": [
                            "0": "default"
                        ]
                    ])
                    
                    //login w/ new account
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "navbar")
                    self.present(vc!, animated: true, completion: nil)
                    print((user?.uid)!)
                    
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "auth"){
            if let tabVC = segue.destination as? UIViewController{
                tabVC.modalPresentationStyle = .custom
                tabVC.modalTransitionStyle = .crossDissolve
            }
        }
    }
}
