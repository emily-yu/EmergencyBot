//
//  UrgentController.swift
//  TwilioSms
//
//  Created by Emily on 5/28/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Firebase

class EmergencyController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let cellReuseIdentifier = "cell"
    var ref = FIRDatabase.database().reference()
    
    @IBAction func emergencyPress(_ sender: Any) {
        print("TODO: Send Message After Delay")
        
//        let headers = [
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//        
//        let parameters: Parameters = [
//            "To": String(contact), //loop this through emergencyContacts
//            //            "From": yourNumber,
//            "Body": messageField.text ?? ""
//        ]
        
        //"http://41e888fa.ngrok.io/login?userid=\(userID)"
        
        var userID = FIRAuth.auth()!.currentUser!.uid
        
        Alamofire.request("http://6cfad110.ngrok.io/test?userid=\(userID)").response { response in
            print(response)
            
        }
        
    }
    
    @IBAction func delayInfo(_ sender: Any) {
        print("TODO: retrieve delays from all contacts being used and average their delay times")
    }
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:EmergencyControllerCell = self.tableView.dequeueReusableCell(withIdentifier: "EmergencyControllerCell") as! EmergencyControllerCell
        
        cell.cellHeader.text = animals[indexPath.row]
        cell.cellSubtitle.text = String(troll[indexPath.row])
//        tableView.rowHeight = 80
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        tableView.deselectRow(at: indexPath, animated: true)
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
}

class EmergencyControllerCell: UITableViewCell {
    @IBOutlet var cellHeader: UILabel!
    @IBOutlet var cellSubtitle: UILabel!
    
}
