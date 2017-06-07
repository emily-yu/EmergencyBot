//
//  NewContactController.swift
//  TwilioSms
//
//  Created by Emily on 3/1/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class NewContactController: UIViewController {
    
    var ref: FIRDatabaseReference!
    
    @IBOutlet var name: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var additionalNotes: UITextView!
    @IBOutlet var delayLabel: UILabel!
    @IBOutlet var stepperVal: UIStepper!
    @IBAction func stepper(_ sender: Any) {
        var stepperText = stepperVal.value
        delayLabel.text = "Delay(sec) \(stepperText)"
    }
    
    @IBAction func submitButton(_ sender: Any) {
        ref = FIRDatabase.database().reference()
        if (phoneNumber.text != "" ){
            
            // Local
            contactNames.append(name.text!)
            contactNumbers.append(Int(phoneNumber.text!)!)
            contactAdditionalInfo.append(additionalNotes.text)
            contactDelay.append(Float(stepperVal.value))
            
            // Firebase
            self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
                var count = String((((snapshot.value!) as AnyObject).count))
                self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").child(count).setValue([
                    "delay": self.stepperVal.value,
                    "name": self.name.text,
                    "notes": self.additionalNotes.text,
                    "number": Int(self.phoneNumber.text!),
                    "sendLocation": false
                ])
            }
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "navbar")
            self.present(vc!, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Submission Error", message: "You cannot create a contact without a phone number.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
         stepperVal.autorepeat = true
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "contactSegue") {
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 0
                tabVC.modalPresentationStyle = .custom
                tabVC.modalTransitionStyle = .crossDissolve
            }
        }
    }
    
}
