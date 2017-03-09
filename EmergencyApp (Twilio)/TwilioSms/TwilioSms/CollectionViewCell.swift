//
//  CollectionViewCell.swift
//  TwilioSms
//
//  Created by Emily on 3/7/17.
//  Copyright © 2017 Emily. All rights reserved.
//

import UIKit

class CollectionViewCell: UITableViewCell {
    
    @IBOutlet var cellHeader: UILabel!
    @IBOutlet var cellSubtitle: UILabel!
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell:CollectionViewCell = self.tableView.dequeueReusableCellWithIdentifier("CollectionViewCell") as! CollectionViewCell
//
//        cell.cellHeader?.text = "same"
//        return cell
//    }
}
