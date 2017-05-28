//
//  CustomizeContact.swift
//  TwilioSms
//
//  Created by Emily on 5/28/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import UIKit
import Foundation

class CustomContactController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
//        stepperVal.autorepeat = true
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
