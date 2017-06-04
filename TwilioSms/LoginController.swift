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
                    
                    // import contacts (name, number, delay, additional notes)
                    self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").observe(.value, with: {      snapshot in
                        let count = Int(snapshot.childrenCount-1)
                        if (count > 0) { // has elements to import
                            for i in 1...snapshot.childrenCount-1 { // iterate from post 1
                                
                                let importPath = self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts")
                                importPath.child(String(i)).child("name").observe(.value, with: {      snapshot in
                                    contactNames.append(snapshot.value as! String)
                                    if (contactNames.count == count) { // array is not missing data
                                        print("CONTACT NAMES: \(contactNames)")
                                    }
                                })
                                importPath.child(String(i)).child("number").observe(.value, with: {      snapshot in
                                    contactNumbers.append(snapshot.value as! Int)
                                    if (contactNumbers.count == count) { // array is not missing data
                                        print("CONTACT NUMBERS: \(contactNumbers)")
                                    }
                                })
                                importPath.child(String(i)).child("delay").observe(.value, with: {      snapshot in
                                    contactDelay.append(snapshot.value as! Float)
                                    if (contactDelay.count == count) { // array is not missing data
                                        print("CONTACT DELAY: \(contactDelay)")
                                    }
                                })
                                importPath.child(String(i)).child("notes").observe(.value, with: {      snapshot in
                                    contactAdditionalInfo.append(snapshot.value as! String)
                                    if (contactAdditionalInfo.count == count) { // array is not missing data
                                        print("CONTACT NOTES: \(contactAdditionalInfo)")
                                    }
                                })
                            }
                        }
                        else { // no elements to import
                        }
                    })
                    
                    // import emergency contacts (name, numbers)
                    let refPath = self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("emergencyContact")
                    refPath.observe(.value, with: {      snapshot in
                        let count = Int(snapshot.childrenCount-1)
                        if (count > 0) { // has elements to import
                            
                            /*
                             for each element in emergencyContacts
                                find element in contacts by phone number and retrive key
                                    find where in contacts-number array it is
                                    use that index to get the details (name, number, delay) from the contacts firebase
                            */
                            
                            for i in 1...snapshot.childrenCount-1 { // iterate from post 1
                                refPath.child(String(i)).observe(.value, with: {      snapshot in // for each element in emergencyContacts
                                    
                                    // search
                                    let textToFind = snapshot.value! as? Int
                                    self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").queryOrdered(byChild: "number").queryEqual(toValue:textToFind).observe(.value, with: { snapshot in
                                        if (snapshot.value is NSNull) {
                                            print("Skillet was not found")
                                        }
                                        else {
                                            for child in snapshot.children {   //in case there are several skillets
                                                let key = (child as AnyObject).key as String
                                                
                                                emergencyIndexes.append(key)
                                                
                                                let importPath = self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts")
                                                importPath.child(String(key)).child("name").observe(.value, with: {      snapshot in
                                                    emergencyNames.append((snapshot.value! as? String)!)
                                                    if (emergencyNames.count == count) { // array is not missing data
                                                        print("EMERGENCY NAMES: \(emergencyNames)")
                                                    }
                                                })
                                                importPath.child(String(key)).child("number").observe(.value, with: {      snapshot in
                                                    emergencyNumbers.append((snapshot.value! as? Int)!)
                                                    if (emergencyNumbers.count == count) { // done importing
                                                        print("EMERGENCY NUMBERS: \(emergencyNumbers)")
                                                        let ivc = self.storyboard?.instantiateViewController(withIdentifier: "navbar")
                                                        ivc?.modalPresentationStyle = .custom
                                                        ivc?.modalTransitionStyle = .crossDissolve
                                                        self.present(ivc!, animated: true, completion: { _ in })
                                                    }
                                                })
                                                importPath.child(String(key)).child("delay").observe(.value, with: {      snapshot in
                                                    emergencyDelay.append((snapshot.value! as? Float)!)
                                                    if (emergencyDelay.count == count) { // done importing
                                                        print("EMERGENCY DELAY: \(emergencyDelay)")
                                                        let ivc = self.storyboard?.instantiateViewController(withIdentifier: "navbar")
                                                        ivc?.modalPresentationStyle = .custom
                                                        ivc?.modalTransitionStyle = .crossDissolve
                                                        self.present(ivc!, animated: true, completion: { _ in })
                                                    }
                                                })
                                            }
                                        }
                                    })
                                    
                                    
                                })
                            }
                        }
                        else { // no elements to import
                        }
                    })
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
