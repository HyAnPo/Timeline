//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
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
    var searchController: UISearchController!
    
    
    
    // MARK: - Outlets
    @IBOutlet var modeSegmentedControl: UISegmentedControl!

    
    
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
    
    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode()
        setupSearchController()
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
    
    func setupSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("searchResultsView")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTextString = searchController.searchBar.text!.lowercaseString
        
        let resultsViewController = searchController.searchResultsController as! SearchResultsTableViewController
        
        resultsViewController.usersResultsDataSource = usersDataSource.filter({$0.username.lowercaseString.containsString(searchTextString)})
        resultsViewController.tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toProfileView" {
            guard let cell = sender as? UITableViewCell else { return }
            
            if let destinationViewController = segue.destinationViewController as? ProfileViewController, let indexPath = tableView.indexPathForCell(cell) {
                destinationViewController.user = usersDataSource[indexPath.row]
                
            } else if let indexPath = (searchController.searchResultsController as? SearchResultsTableViewController)?.tableView.indexPathForCell(cell) {
                let user = (searchController.searchResultsController as! SearchResultsTableViewController).usersResultsDataSource[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.user = user
            }
        }
    }
}





























