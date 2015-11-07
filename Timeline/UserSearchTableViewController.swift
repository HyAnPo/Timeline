//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    enum ViewMode: Int {
        case Friends
        case All
        
        func users(completion: (users: [User]?) -> Void) {
            
            switch self {
            case .Friends:
                UserController.followedByUser(UserController.sharedController.currentUser, completion: { (users) -> Void in
                    completion(users: users)
                })
                
            case .All:
                UserController.fetchAllUsers({ (users) -> Void in
                    completion(users: users)
                })
            }
        }
    }
    
    
    // MARK: - Properties
    
    var usersDataSource: [User] = []
    var searchController: UISearchController!
    
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    var mode: ViewMode {
            return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
    }
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewBasedOnMode()
        setUpSearchController()
    }
    
    func updateViewBasedOnMode() {
        self.mode.users() { (users) -> Void in
            if let users = users {
                self.usersDataSource = users
            } else {
                self.usersDataSource = []
            }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Search Controller
    
    func setUpSearchController() {
        
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserSearchTableViewController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchTerm = searchController.searchBar.text!.lowercaseString
        
        let resultsViewController = searchController.searchResultsController as! UserSearchTableViewController
        
        resultsViewController.usersDataSource = self.usersDataSource.filter({$0.username.lowercaseString.containsString(searchTerm)})
        resultsViewController.tableView.reloadData()
    }
    
    
    @IBAction func selectedIndexChanged(sender: UISegmentedControl) {
        updateViewBasedOnMode()
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("usernameCell", forIndexPath: indexPath)
        
        let user = usersDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username
        


        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toProfileView" {
            guard let cell = sender as? UITableViewCell else { return }
            
            if let indexPath = tableView.indexPathForCell(cell) {
                let user = usersDataSource[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.user = user
                
            } else if let indexPath = (searchController.searchResultsController as! UserSearchResultsTableViewController).tableView.indexPathForCell(cell) {
                
                let user = (searchController.searchResultsController as! UserSearchResultsTableViewController).usersResultsDataSource[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.user = user
            }
        }
    }


   

}
