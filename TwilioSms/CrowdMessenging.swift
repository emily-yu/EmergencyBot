//
//  ViewController.swift
//  TwilioSms
//
//  Created by Emily on 2/8/17.
//  Copyright © 2017 Emily. All rights reserved.

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellReuseIdentifier = "cell"
    var selectedCells: [Int] = [] // indexes
    
//    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var messageField: UITextView!
    @IBOutlet var tableView: UITableView! // filler values
    @IBAction func sendData(sender: AnyObject) {

    }
    
    func sendMessage(contact:Int){
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To": String(contact), //loop this through emergencyContacts
            "From": yourNumber, // not sure if like same works right now
            "Body": messageField.text ?? ""
        ]
        
        Alamofire.request("\(ngrok)/sms", method: .post, parameters: parameters, headers: headers).response { response in
            print(response)
        }
    }
    
    override func viewDidLoad() {
//        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        
        // set up the tableView
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNames.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CrowdMessengingCell = self.tableView.dequeueReusableCell(withIdentifier: "CrowdMessengingCell") as! CrowdMessengingCell
        
        cell.cellHeader.text = contactNames[indexPath.row]
        cell.cellSubtitle.text = String(contactNumbers[indexPath.row])
        cell.cellStatus.isHidden = true
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let cell:CrowdMessengingCell = self.tableView.cellForRow(at: indexPath)! as! CrowdMessengingCell
        // visual tracking
        if (cell.cellStatus.isHidden == true) {
            cell.cellStatus.isHidden = false
            selectedCells.append(indexPath.row)
        }
        else {
            cell.cellStatus.isHidden = true
            selectedCells = selectedCells.filter {$0 != (indexPath.row)} // remove cell
        }
        print("ARRAY: \(selectedCells)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class CrowdMessengingCell: UITableViewCell {
    @IBOutlet var cellHeader: UILabel!
    @IBOutlet var cellSubtitle: UILabel!
    @IBOutlet var cellStatus: UILabel!
}
