//
//  User.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

struct User: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kBio = "bio"
    private let kURL = "url"
    
    let username: String
    var bio: String?
    var url: String?
    let uid: String?
    
    var endpoint: String {
        return "users"
    }
    
    var jsonValue: [String : AnyObject] {
        var json: [String: AnyObject] = [kUsername: username]
        
        if let bio = self.bio {
            json.updateValue(bio, forKey: kBio)
        }
        
        if let url = self.url {
            json.updateValue(url, forKey: kURL)
        }
        
        return json
    }
    
    init(username: String, uid: String?, bio: String? = nil, url: String? = nil) {
        self.username = username
        self.bio = bio
        self.url = url
        self.uid = uid
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String else { return nil }
        
        self.username = username
        self.uid = identifier
        self.bio = json[kBio] as? String
        self.url = json[kURL] as? String
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.username == rhs.username && lhs.uid == rhs.uid
}





















