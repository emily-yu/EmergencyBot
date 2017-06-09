//
//  AddEmergencyController.swift
//  TwilioSms
//
//  Created by Emily on 5/28/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import Foundation
import UIKit

class AddEmergencyController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let cellReuseIdentifier = "cell"
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let cell:AddEmergencyControllerCell = self.tableView.dequeueReusableCell(withIdentifier: "AddEmergencyControllerCell") as! AddEmergencyControllerCell
        
        cell.cellHeader.text = contactNames[indexPath.row]
        cell.cellSubtitle.text = String(contactNumbers[indexPath.row])
        //        tableView.rowHeight = 80
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "urgentSegue"){
            
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 2
                tabVC.modalPresentationStyle = .custom
                tabVC.modalTransitionStyle = .crossDissolve
            }
        }
    }
}

class AddEmergencyControllerCell: UITableViewCell {
    @IBOutlet var cellSubtitle: UILabel!
    @IBOutlet var cellHeader: UILabel!
}
