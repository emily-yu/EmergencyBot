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
    var netDelay: Float = 0.0
    
    @IBOutlet var delayLabel: UILabel!
    @IBAction func emergencyPress(_ sender: Any) {
        print("TODO: Send Message")
        
        if let same = (delayLabel.text)?.components(separatedBy: ": ").last {
            print(same)
            let time2 = (same as NSString).intValue
            let seconds = Double(time2)
            let when = DispatchTime.now() + seconds
            
            let alert = UIAlertController(title: "False Alarm", message: "Please hit 'OK' if the user letting go of the button was a false alarm. Otherwise, a message for help will be sent in \(when) seconds.", preferredStyle: .alert)
            //            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            let task = DispatchWorkItem {
                print("ruh roh")
                alert.dismiss(animated: true, completion: nil)
//                 Sending Message
                if (emergencyNumbers.count != 0) {
                    for contact in emergencyNumbers {
                        self.sendMessage(contact: emergencyNumbers[contact])
                    }
                }
                else {
                    let alertController = UIAlertController(title: "No target destination", message: "Please select at least one contact in the menu below to send your message to.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            // execute task in 2 seconds - start queueu
            DispatchQueue.main.asyncAfter(deadline: when, execute: task)
        
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                task.cancel()
            })
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func sendMessage(contact:Int){
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To": String(contact),
            "From": yourNumber,
            "Body": emergencyMessage ?? ""
        ]
        
        Alamofire.request("\(ngrok)/sms", method: .post, parameters: parameters, headers: headers).response { response in
            print(response)
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
    
        for (index, time) in emergencyDelay.enumerated() {
            netDelay = netDelay + time
            if (index == emergencyDelay.count-1) { // done
                netDelay = netDelay/(Float(emergencyDelay.count))
                delayLabel.text = "Delay Time (sec): \(netDelay)"
            }
        }
        
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
        let cell:EmergencyControllerCell = self.tableView.dequeueReusableCell(withIdentifier: "EmergencyControllerCell") as! EmergencyControllerCell
        
        cell.cellHeader.text = emergencyNames[indexPath.row]
        cell.cellSubtitle.text = String(emergencyNumbers[indexPath.row])
        
        return cell
    }
}

class EmergencyControllerCell: UITableViewCell {
    @IBOutlet var cellHeader: UILabel!
    @IBOutlet var cellSubtitle: UILabel!
    
}
