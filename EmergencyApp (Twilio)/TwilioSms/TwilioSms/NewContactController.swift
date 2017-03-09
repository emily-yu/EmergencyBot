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
    @IBOutlet var additionalNotes: UITextField!
    
    @IBAction func submitButton(_ sender: Any) {
        if (phoneNumber.text != ""){
            // append textfields to array
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Contacts")
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
    
}
