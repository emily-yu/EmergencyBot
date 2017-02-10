//
//  FirstViewController.swift
//  Emergency App
//
//  Created by Emily on 2/8/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var phoneNumber = "42390482390483204"
    
    /*
     Emergency detection thing
     a really good well designed app
     that like basically when u press a button
     sends a notification to everyone with an app
     puush notification
     basically an app with a button
     and then every time u get raped or are in trouble
     you press the button
     and it sends a push notification to everyone
     for extra points
     make it a bot that messages everyone
     cause people fucking love messenger bots
     I need an adult. Find an adult near you. Fun times ens

 */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var status: UILabel! // Status
    
    // Emergency Button
    @IBAction func emergencyButton(_ sender: UIButton) {
        // use twilio programmable sms
        //store phone numbers in an array
    }
    
    
    // on off button for activation
    @IBAction func statusButton(_ sender: Any) {
        status.text = "Status: Activated"
    }

}

