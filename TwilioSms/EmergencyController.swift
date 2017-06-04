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
    
    @IBOutlet var delayLabel: UILabel!
    @IBAction func emergencyPress(_ sender: Any) {
        print("TODO: Send Message")
        
        if let same = (delayLabel.text)?.components(separatedBy: ": ").last {
            print(same)
            let time2 = (same as NSString).intValue
            let seconds = Double(time2)
            let when = DispatchTime.now() + seconds
            DispatchQueue.main.asyncAfter(deadline: when){
                print("same")
                var userID = FIRAuth.auth()!.currentUser!.uid
                // replace this with the sending thing
                Alamofire.request("\(ngrok)/test?userid=\(userID)").response { response in
                    print(response)
                }
            }
        }
        
    }
    
    @IBAction func delayInfo(_ sender: Any) {
        let alertController = UIAlertController(title: "Delay Time", message: "From the contacts set as emergency contacts, the delay times inputted as individual times are averaged out and an overall delay time is calculated.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
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
        return emergencyNames.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:EmergencyControllerCell = self.tableView.dequeueReusableCell(withIdentifier: "EmergencyControllerCell") as! EmergencyControllerCell
        
        cell.cellHeader.text = emergencyNames[indexPath.row]
        cell.cellSubtitle.text = String(emergencyNumbers[indexPath.row])
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
