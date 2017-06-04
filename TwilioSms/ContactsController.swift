//
//  CustomizeController.swift
//  TwilioSms
//
//  Created by Emily on 3/1/17.
//  Copyright © 2017 Emily. All rights reserved.
//


import UIKit
class CustomizeController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let cellReuseIdentifier = "cell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var addContact: UIBarButtonItem!
    
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
        var cell:CollectionViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CollectionViewCell") as! CollectionViewCell

        cell.cellHeader.text = contactNames[indexPath.row]
        cell.cellSubtitle.text = String(contactNumbers[indexPath.row])
        cell.delayTime.text = "Delay Time: \(String(contactDelay[indexPath.row]))"
        cell.additionalNotes.text = contactAdditionalInfo[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        clickedIndex = indexPath.row
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            // populate placeholders in customizeContact with the current values
            let ivc = self.storyboard?.instantiateViewController(withIdentifier: "customizeContact")
            ivc?.modalPresentationStyle = .custom
            ivc?.modalTransitionStyle = .crossDissolve
            self.present(ivc!, animated: true, completion: { _ in })
        })
        editAction.backgroundColor = UIColor(red:0.59, green:0.73, blue:0.95, alpha:1.0)
        return [editAction]
    }
}

class CollectionViewCell: UITableViewCell {
    @IBOutlet var cellHeader: UILabel!
    @IBOutlet var cellSubtitle: UILabel!
    @IBOutlet var delayTime: UILabel!
    @IBOutlet var additionalNotes: UILabel!
}
