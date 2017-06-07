//
//  CustomizeContact.swift
//  TwilioSms
//
//  Created by Emily on 5/28/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class CustomizeContactController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var additionalNotes: UITextView!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var deleteContact: UIButton!
    @IBOutlet var delayLabel: UILabel!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Name
        name.text = nil
        name.placeholder = contactNames[clickedIndex]
        
        // Phone Number
        phoneNumber.text = nil
        phoneNumber.placeholder = String(contactNumbers[clickedIndex])
        
        // Delay Time
        stepper.autorepeat = true
        
        // Additional Notes
        additionalNotes.text = contactAdditionalInfo[clickedIndex]
        additionalNotes.textColor = UIColor.lightGray
    }
    
    @IBAction func done(_ sender: Any) {
        // Saved Locally
        ref = FIRDatabase.database().reference()
        let contactPath = self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("contacts").child(String(clickedIndex))
        
        if emergencyIndexes.contains("\(clickedIndex)") { // is an emergency contact
            let eIndex = emergencyIndexes.index(of:"\(clickedIndex)")
            if (name.text != nil) {
                emergencyNames[eIndex!] = name.text!
                contactNames[clickedIndex] = name.text!
                contactPath.child("name").setValue(name.text!)
            }
            else if (phoneNumber.text != nil) {
                emergencyNumbers[eIndex!] = Int(phoneNumber.text!)!
                self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("emergencyContact").child(String(describing: eIndex)).setValue(Int(phoneNumber.text!))
                
                contactNumbers[clickedIndex] = Int(phoneNumber.text!)!
                contactPath.child("number").setValue(Int(phoneNumber.text!))
            }
            else if (Float(stepper.value) != emergencyDelay[eIndex!]) {
                emergencyDelay[eIndex!] = Float(stepper.value)
                contactDelay[clickedIndex] = Float(stepper.value)
                contactPath.child("delay").setValue(Float(stepper.value))
            }
            else if (additionalNotes.text != contactAdditionalInfo[clickedIndex]) {
                contactAdditionalInfo[clickedIndex] = additionalNotes.text
                contactPath.child("notes").setValue(additionalNotes.text)
            }
        }
        else {
            if (name.text != nil) {
                contactNames[clickedIndex] = name.text!
                contactPath.child("name").setValue(name.text!)
            }
            else if (phoneNumber.text != nil) {
                contactNumbers[clickedIndex] = Int(phoneNumber.text!)!
                contactPath.child("number").setValue(Int(phoneNumber.text!))
            }
            else if (Float(stepper.value) != contactDelay[clickedIndex]) {
                contactDelay[clickedIndex] = Float(stepper.value)
                contactPath.child("delay").setValue(Float(stepper.value))
            }
            else if (additionalNotes.text != contactAdditionalInfo[clickedIndex]) {
                contactAdditionalInfo[clickedIndex] = additionalNotes.text
                contactPath.child("notes").setValue(additionalNotes.text)
            }
        }
    }
    
    @IBAction func stepperPressed(_ sender: Any) {
        let stepperText = stepper.value
        delayLabel.text = "Delay(sec) \(stepperText)"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "contactSegue"){
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 0
                tabVC.modalPresentationStyle = .custom
                tabVC.modalTransitionStyle = .crossDissolve
            }
        }
    }
    
}
