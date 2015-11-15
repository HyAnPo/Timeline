//
//  UserController.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import Foundation

class UserController {
    
    let currentUser: User! = UserController.mockUsers().first
    
    static let sharedController = UserController()
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        completion(user: mockUsers().first)
    }
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        completion(users: mockUsers())
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        
    }
    
    static func userFollowsUser(user: User, userCheck: User, completion: (follows: Bool) -> Void) {
        
    }
    
    static func followedByUser(user: User, completion: (users: [User]?) -> Void) {
        completion(users: [mockUsers()[0], mockUsers()[2]])
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    static func logOutCurrentUser() {
        
    }
    
    static func mockUsers() -> [User] {
        
        let user1 = User(username: "Andrew", bio: "Fun", url: "www.porter.com", identifier: "iOS")
        let user2 = User(username: "Libby", bio: "Craft", url: "www.libby.com", identifier: "School")
        let user3 = User(username: "Hyrum", bio: "Volleyball", url: "www.hyrum.com", identifier: "Work")
        let user4 = User(username: "hansolo", identifier: "1233")
        let user5 = User(username: "ob1kenob", identifier: "08098324")
        let user6 = User(username: "3p0", identifier: "23408")
        let user7 = User(username: "leia", bio: "Princess", url: "myspace.com", identifier: "2093")
        
        return [user1, user2, user3, user4, user5, user6, user7]
    }
    
    
    
}