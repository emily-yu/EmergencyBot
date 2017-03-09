//
//  ViewController.swift
//  TwilioSms
//
//  Created by Emily on 2/8/17.
//  Copyright © 2017 Emily. All rights reserved.
// To run: python app.py in one terminal shell, then ./ngrok http 5000 in another and then run xcode
//

import UIKit
import Alamofire
import Contacts

class ViewController: UIViewController {
    
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var messageField: UITextField!
    
    @IBAction func sendData(sender: AnyObject) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To": phoneNumberField.text ?? "",
            "Body": messageField.text ?? ""
        ]
        
        Alamofire.request("http://a6ecc643.ngrok.io/sms", method: .post, parameters: parameters, headers: headers).response { response in
            print(response)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
