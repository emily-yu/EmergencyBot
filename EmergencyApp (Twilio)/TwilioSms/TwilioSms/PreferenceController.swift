//
//  CustomizeController.swift
//  TwilioSms
//
//  Created by Emily on 3/1/17.
//  Copyright © 2017 Emily. All rights reserved.
//

//import UIKit
//import APAddressBook
//
//fileprivate let cellIdentifier = String(describing: UITableViewCell.self)
//
//class CustomizeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//

import UIKit
import Foundation

class PreferenceController: UIViewController {
    @IBOutlet var pTableView: UITableView!
    
       override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}


//let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
//alert.addTextField { (textField) in
//    textField.text = "Some default text"
//}
//alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//    let textField = alert.textFields![0] // Force unwrapping because we know it exists.
//    print("Text field: \(textField.text)")
//}))
//self.present(alert, animated: true, completion: nil)
