//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController {
    
    enum ViewMode: Int {
        case Friends
        case All
        
        func users(completion: (users: [User]?) -> Void) {
            switch self {
            case .Friends:
                UserController.followedByUser(UserController.sharedController.currentUser, completion: { (users) in
                    completion(users: users)
                })
                
            case .All:
                UserController.fetchAllUsers({ (users) in
                    completion(users: users)
                })
            }
        }
    }
    
    // MARK: - Properties
    var usersDataSource: [User] = []
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
        }
    }
    
    // MARK: - Outlets
    @IBOutlet var modeSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode()
    }
    
    func updateViewBasedOnMode() {
        mode.users { (users) in
            if let users = users {
                self.usersDataSource = users
            } else {
                self.usersDataSource = []
            }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    @IBAction func selectedIndexChanged(sender: UISegmentedControl) {
        updateViewBasedOnMode()
    }
    
    // MARK: - TableView Data Source methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        let user = usersDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username
        return cell
    }
    
}
