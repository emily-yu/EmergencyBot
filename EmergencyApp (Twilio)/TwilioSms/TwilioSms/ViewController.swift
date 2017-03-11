//
//  ViewController.swift
//  TwilioSms
//
//  Created by Emily on 2/8/17.
//  Copyright © 2017 Emily. All rights reserved.
// To run: python app.py in one terminal shell, then ./ngrok http 5000 in another and then run xcode


//sending for multiple works - make custom messages? and deploy to heroku

import UIKit
import Alamofire

var emergencyContacts: [Int] = [6505754922, 6505754922]

class ViewController: UIViewController {
    
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var messageField: UITextField!
    
    @IBAction func sendData(sender: AnyObject) {
        for i in emergencyContacts {
            sendMessage(contact: i);
            
        }
    }
    
    func sendMessage(contact:Int){
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To": String(contact), //loop this through emergencyContacts
            "Body": messageField.text ?? ""
        ]
        
        Alamofire.request("http://0f1f1feb.ngrok.io/sms", method: .post, parameters: parameters, headers: headers).response { response in
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
