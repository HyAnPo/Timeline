//
//  UserController.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

class UserController {
    
    private let kUser = "user"
    
    var currentUser: User! {
        get {
            guard let uid = FirebaseController.base.authData.uid,
                    userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(kUser) as? [String: AnyObject] else { return nil }
            
            return User(json: userDictionary, identifier: uid)
        }
        
        set {
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    static let sharedController = UserController()
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.dataAtEndpoint("users/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let user = User(json: data, identifier: identifier)
                
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        
        FirebaseController.dataAtEndpoint("users") { (data) in
            if let json = data as? [String: AnyObject] {
                let users = json.flatMap({User(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                
                completion(users: users)
            } else {
                completion(users: [])
            }
        }
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        
        FirebaseController.base.childByAppendingPath("/users/\(sharedController.currentUser.uid)/follows/\(user.uid)").setValue(true)
        
        completion(success: true)
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        
        FirebaseController.base.childByAppendingPath("/users/\(sharedController.currentUser.uid)/follows/\(user.uid)").removeValue()
        
        completion(success: true)
    }
    
    static func userFollowsUser(user: User, checkUser: User, completion: (follows: Bool) -> Void) {
        
        FirebaseController.dataAtEndpoint("/users/\(UserController.sharedController.currentUser)/follows/\(checkUser.uid)") { (data) in
            
            if let _ = data {
                completion(follows: true)
            } else {
                completion(follows: false)
            }
        }
    }
    
    static func followedByUser(user: User, completion: (users: [User]?) -> Void) {
        
        FirebaseController.dataAtEndpoint("users/\(user.uid)/follows") { (data) in
            
            if let jsonData = data as? [String: AnyObject] {
                var users: [User] = []
                
                for userJson in jsonData {
                    userForIdentifier(userJson.0, completion: { (user) in
                        
                        if let user = user {
                            users.append(user)
                            completion(users: users)
                        }
                    })
                }
            } else {
                completion(users: [])
            }
        }
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
    
        FirebaseController.base.authUser(email, password: password) { (error, response) in
            
            if let error = error {
                completion(success: false, user: nil)
                print(error.localizedDescription)
            } else {
                print("User ID: \(response.uid) authenticated successfully.")
                UserController.userForIdentifier(response.uid, completion: { (user) in
                    if let user = user {
                        sharedController.currentUser = user
                    }
                    
                    completion(success: true, user: user)
                })
            }
        }
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
        FirebaseController.base.createUser(email, password: password) { (error, responseDict) in
            
            if error != nil {
                print("There was an error creating user.")
                print(error.localizedDescription)
                completion(success: false, user: nil)
            } else {
                let uid = responseDict["uid"] as? String
                
                var user = User(username: username, uid: uid, bio: bio, url: url)
                user.save()
                
                UserController.authenticateUser(email, password: password, completion: { (success, user) in
                    
                    completion(success: true, user: user)
                })
            }
        }
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
        var updatedUser = User(username: username, uid: user.uid, bio: bio, url: url)
        updatedUser.save()
        
        UserController.userForIdentifier(user.uid!) { (user) in
            
            if let user = user {
                sharedController.currentUser = user
            } else {
                completion(success: false, user: nil)
            }
        }
    }
    
    static func logoutCurrentUser() {
        FirebaseController.base.unauth()
        sharedController.currentUser = nil
    }
    
    static func mockUsers() -> [User] {
        
        let user1 = User(username: "Andrew", uid: "1234", bio: "Have Fun!", url: "https://www.macrumors.com")
        let user2 = User(username: "Hyrum", uid: "2345")
        let user3 = User(username: "Porter", uid: "3456")
        
        return [user1, user2, user3]
    }
    
    
}















