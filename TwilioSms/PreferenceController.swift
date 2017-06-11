//
//  PreferenceController.swift
//  TwilioSms
//
//  Created by Emily on 6/2/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PreferenceController: UIViewController {
    
    @IBOutlet var countryCode: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var verification: UITextField!
    @IBOutlet var emergencyText: UITextView!

    
    @IBAction func changeMessage(_ sender: Any) {
        
        emergencyMessage = emergencyText.text
        
        let alertController = UIAlertController(title: "Emergency Message Changed", message: "Your preferred message has successfully been changed. Contacts will now be messaged with your new message.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func info(_ sender: Any) {
        let alertController = UIAlertController(title: "Phone Number Verification", message: "To use a number with EmergencyBot, you must first verify it. A verification code will be sent via SMS to the number inputted.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sendVerification(_ sender: Any) {
        Alamofire.request("\(ngrok)/sendverificationcode?countrycode=\(countryCode.text)&number=\(phoneNumber.text)").response { response in
        }
        
        // check if it went through
        let alertController = UIAlertController(title: "Phone Number Verification", message: "A verification code has been sent to +\(countryCode.text) \(phoneNumber.text).", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func verifyCode(_ sender: Any) {
        Alamofire.request("\(ngrok)/verify?code=\(verification.text)&phone_number=\(phoneNumber.text)&country_code=\(countryCode.text)").response { response in
        }
        
        // check if it went through
        let alertController = UIAlertController(title: "Phone Number Verification", message: "The phone number +\(countryCode.text) \(phoneNumber.text) has been verified.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emergencyText.text = emergencyMessage
    }
    
}
