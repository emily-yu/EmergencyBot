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
        ref = FIRDatabase.database().reference()
        if self.email.text == "" || self.password.text == "" {

            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                    
                    print("You have successfully logged in")
                    
                    // retrieve message
                    self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("emergencyMessage").observe(.value, with: {      snapshot in
                        emergencyMessage = snapshot.value as! String
                    })

                    let ivc = self.storyboard?.instantiateViewController(withIdentifier: "navbar")
                    ivc?.modalPresentationStyle = .custom
                    ivc?.modalTransitionStyle = .crossDissolve
                    self.present(ivc!, animated: true, completion: { _ in })
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "auth"){
            if let tabVC = segue.destination as? UIViewController{
                tabVC.modalPresentationStyle = .custom
                tabVC.modalTransitionStyle = .crossDissolve
            }
        }
    }

}
