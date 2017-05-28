//
//  ViewController.swift
//  TwilioSms
//
//  Created by Emily on 2/8/17.
//  Copyright © 2017 Emily. All rights reserved.

//sending for multiple works - make custom messages?

import UIKit
import Alamofire

var emergencyContacts: [Int] = [6505754922, 6505754922]

// not being used
var yourNumber = 6505754922 // find way to verify the number for twilio
var isVerified = false // tracks whether your number is verified
var verifiedNumbers: [Int] = [16504223512] // list of verified numbers

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var messageField: UITextView!
    @IBOutlet var tableView: UITableView! // filler values
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
//            "From": yourNumber,
            "Body": messageField.text ?? ""
        ]
        
        Alamofire.request("http://emergency-app-twilio.herokuapp.com/sms", method: .post, parameters: parameters, headers: headers).response { response in
            print(response)
            
        }
    }
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        
        // set up the tableView
        let cellReuseIdentifier = "cell"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:CrowdMessengingCell = self.tableView.dequeueReusableCell(withIdentifier: "CrowdMessengingCell") as! CrowdMessengingCell
        
        cell.cellHeader.text = animals[indexPath.row]
        cell.cellSubtitle.text = String(troll[indexPath.row])
        tableView.rowHeight = 60
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            animals.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
        })
        editAction.backgroundColor = UIColor.blue
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class CrowdMessengingCell: UITableViewCell {
    @IBOutlet var cellHeader: UILabel!
    @IBOutlet var cellSubtitle: UILabel!
}
