//
//  NewContactController.swift
//  TwilioSms
//
//  Created by Emily on 3/1/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import UIKit
import Foundation

class NewContactController: UIViewController {
    
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
        if (phoneNumber.text != "" ){
            // append textfields to array
            contactNames.append(name.text!)
            contactNumbers.append(Int(phoneNumber.text!)!)
            
            // save new array
            
            // add to firebase
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "navbar")
            self.present(vc!, animated: true, completion: nil)
        }
        else {
            //Error
            let alertController = UIAlertController(title: "Submission Error", message: "gg need a phone number troll", preferredStyle: .alert)
            
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
        if(segue.identifier == "contactSegue"){
            
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 0
                tabVC.modalPresentationStyle = .custom
                tabVC.modalTransitionStyle = .crossDissolve
            }
        }
    }
    
}
