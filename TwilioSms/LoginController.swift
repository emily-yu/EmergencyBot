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
                    
                    // import contacts (name, number)
                    self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").observe(.value, with: {      snapshot in
                        var count = Int(snapshot.childrenCount-1)
                        if (count > 0) { // has elements to import
                            for i in 1...snapshot.childrenCount-1 { // iterate from post 1
                                self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").child(String(i)).child("name").observe(.value, with: {      snapshot in
                                    contactNames.append(snapshot.value as! String)
                                    if (contactNames.count == count) { // array is not missing data
                                        print(contactNames)
                                    }
                                })
                                self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").child(String(i)).child("number").observe(.value, with: {      snapshot in
                                    contactNumbers.append(snapshot.value as! Int)
                                    if (contactNumbers.count == count) { // array is not missing data
                                        print(contactNumbers)
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
                                    use that index to get the details (name, number) from the contacts firebase
                            */
                            
                            for i in 1...snapshot.childrenCount-1 { // iterate from post 1
                                refPath.child(String(i)).observe(.value, with: {      snapshot in // for each element in emergencyContacts
                                    
                                    // search
                                    let textToFind = snapshot.value! as? Int
                                    print(textToFind)
                                    self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").queryOrdered(byChild: "number").queryEqual(toValue:textToFind).observe(.value, with: { snapshot in
                                        if (snapshot.value is NSNull) {
                                            print("Skillet was not found")
                                        }
                                        else {
                                            for child in snapshot.children {   //in case there are several skillets
                                                let key = (child as AnyObject).key as String
                                                self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").child(String(key)).child("name").observe(.value, with: {      snapshot in
                                                    emergencyNames.append((snapshot.value! as? String)!)
                                                    if (emergencyNames.count == count) { // array is not missing data
                                                        print(emergencyNames)
                                                    }
                                                })
                                                self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").child(String(key)).child("number").observe(.value, with: {      snapshot in
                                                    emergencyNumbers.append((snapshot.value! as? Int)!)
                                                    if (emergencyNumbers.count == count) { // array is not missing data
                                                        print(emergencyNumbers)
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
