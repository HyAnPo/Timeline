//
//  UserSearchResultsTableViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 11/5/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import UIKit

class UserSearchResultsTableViewController: UITableViewController {
    
    var usersResultsDataSource: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersResultsDataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        let user = usersResultsDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username


        return cell
    }
    
    //MARK: - Table View Delegate
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let sender = tableView.cellForRowAtIndexPath(indexPath)
//        
//        self.presentingViewController?.performSegueWithIdentifier(<#T##identifier: String##String#>, sender: <#T##AnyObject?#>)
//    }
}









