//
//  SearchResultsTableViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/24/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var usersResultsDataSource: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

    // MARK: - TableView Data Source methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersResultsDataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultsCell", forIndexPath: indexPath)
        let user = usersResultsDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username
        return cell
    }
    
    
    
    // MARK: - TableView Delegate methods
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        presentingViewController?.performSegueWithIdentifier("toProfileView", sender: cell)
    }
}
