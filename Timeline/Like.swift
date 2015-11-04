//
//  Like.swift
//  Timeline
//
//  Created by Andrew Porter on 11/3/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import Foundation

struct Like: Equatable {
    
    let userName: String
    let postIdentifier: String
    let identifier: String?
    
    init(userName: String, postIdentifier: String, identifier: String? = nil) {
        
        self.userName = userName
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
}

func == (lhs: Like, rhs: Like) -> Bool {
    
    return (lhs.userName == rhs.userName) && (lhs.identifier == rhs.identifier)
}