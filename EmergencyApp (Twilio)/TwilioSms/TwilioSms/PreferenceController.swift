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

// todo: sending location, mailcompose for help, create custom messages, save the preferences
import UIKit
import Foundation

class PreferenceController: UITableViewController {
    @IBOutlet var sTableView: UITableView!
    @IBOutlet var isActivated: UISwitch!
    @IBAction func isChanged(_ sender: Any) {
        if isActivated.isOn {
            print("the button is off")
            isActivated.setOn(false, animated:true)
        } else {
            print( "The Switch is On")
            isActivated.setOn(true, animated:true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

    
       override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
//override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    print("You selected cell #\(indexPath.row)!")
//}

//let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
//alert.addTextField { (textField) in
//    textField.text = "Some default text"
//}
//alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//    let textField = alert.textFields![0] // Force unwrapping because we know it exists.
//    print("Text field: \(textField.text)")
//}))
//self.present(alert, animated: true, completion: nil)
