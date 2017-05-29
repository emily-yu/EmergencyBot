//
//  CustomizeContact.swift
//  TwilioSms
//
//  Created by Emily on 5/28/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import UIKit
import Foundation

class CustomizeContactController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var additionalNotes: UITextView!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var deleteContact: UIButton!
    @IBOutlet var delayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        stepper.autorepeat = true
    }
    @IBAction func stepperPressed(_ sender: Any) {
        var stepperText = stepper.value
        delayLabel.text = "Delay(sec) \(stepperText)"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "contactSegue"){
            
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 0
                tabVC.modalPresentationStyle = .custom
                tabVC.modalTransitionStyle = .crossDissolve
                
                // have it save changes
            }
        }
    }
    
}
