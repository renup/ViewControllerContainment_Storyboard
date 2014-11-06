//
//  LeftViewController.swift
//  ViewControllerContainmentTest
//
//  Created by Renu Punjabi on 10/31/14.
//  Copyright (c) 2014 CocoaTeam. All rights reserved.
//

import Foundation
import UIKit

@objc protocol LeftViewDelegate {
    func bringUpRight1VC()
    func bringUpRight2VC()
}

class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    weak var leftDelegate: LeftViewDelegate?
    
    @IBAction func buttonPressed(sender: AnyObject) {
        //Here we want to bring up right1VC in right Container
        leftDelegate?.bringUpRight1VC()
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //Here we want to bring up right2VC in right Container
        leftDelegate?.bringUpRight2VC()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.textLabel.text = String(format: "%i", indexPath.row)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    

    
}
