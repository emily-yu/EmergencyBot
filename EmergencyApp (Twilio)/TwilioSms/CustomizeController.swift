//
//  CustomizeController.swift
//  TwilioSms
//
//  Created by Emily on 3/1/17.
//  Copyright © 2017 Twilio. All rights reserved.
//

import UIKit
import APAddressBook

fileprivate let cellIdentifier = String(describing: UITableViewCell.self)

class CustomizeController: UIViewController
{
    
    @IBOutlet weak var tableView: UITableView!

    let addressBook = APAddressBook()
    var contacts = [APContact]()
    
    // MARK: - life cycle
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
        addressBook.fieldsMask = [APContactField.default, APContactField.thumbnail]
        addressBook.sortDescriptors = [NSSortDescriptor(key: "name.firstName", ascending: true),
                                       NSSortDescriptor(key: "name.lastName", ascending: true)]
        addressBook.filterBlock =
            {
                (contact: APContact) -> Bool in
                if let phones = contact.phones
                {
                    return phones.count > 0
                }
                return false
        }
        addressBook.startObserveChanges
            {
                [unowned self] in
                self.loadContacts()
        }
    }
    
    // MARK: - appearance
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        loadContacts()
    }
    
    // MARK: - actions
    
    @IBAction func reloadButtonPressed(_ sender: AnyObject)
    {
        loadContacts()
    }
    
    // MARK: - private
    
    func loadContacts()
    {
//        activity.startAnimating();
        //load stuff?
        addressBook.loadContacts{
            
            
            
                [unowned self] (contacts: [APContact]?, error: Error?) in
//                self.activity.stopAnimating()
                self.contacts = [APContact]()
                if let contacts = contacts
                {
                    self.contacts = contacts
                    self.tableView.reloadData()
                }
                else if let error = error
                {
                    let alert = UIAlertView(title: "Error", message: error.localizedDescription,
                                            delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
        }
    }
}

// not requesting auth

extension CustomizeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath)
        if let cell = cell as? TableViewCell {
            cell.update(with: contacts[indexPath.row])
        }
        return cell
    }
}

extension CustomizeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
