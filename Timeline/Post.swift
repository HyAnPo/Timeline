//
//  Post.swift
//  Timeline
//
//  Created by Andrew Porter on 3/18/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

struct Post: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kImageEndpoint = "imageEndpoint"
    private let kCaption = "caption"
    private let kComments = "comments"
    private let kLikes = "likes"
    
    let imageEndpoint: String
    let caption: String?
    let username: String
    let comments: [Comment]
    let likes: [Like]
    let uid: String?
    
    var endpoint: String {
        return "posts"
    }
    
    var jsonValue: [String : AnyObject] {
        var json: [String: AnyObject] = [kUsername: username, kImageEndpoint: imageEndpoint, kComments: comments.map({$0.jsonValue}), kLikes: likes.map({$0.jsonValue})]
        
        if let caption = self.caption {
            json.updateValue(caption, forKey: kCaption)
        }
        
        return json
    }
    
    init(imageEndPoint: String, caption: String?, username: String = "", comments: [Comment] = [], likes: [Like] = [], uid: String? = nil) {
        self.imageEndpoint = imageEndPoint
        self.username = username
        self.caption = caption
        self.comments = comments
        self.likes = likes
        self.uid = uid
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String,
                imageEndpoint = json[kImageEndpoint] as? String else { return nil }
        
        self.username = username
        self.imageEndpoint = imageEndpoint
        self.caption = json[kCaption] as? String
        self.uid = identifier
        
        if let commentDicts = json[kComments] as? [String: AnyObject] {
            self.comments = commentDicts.flatMap({Comment(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
        } else {
            self.comments = []
        }
        
        if let likesDicts = json[kLikes] as? [String: AnyObject] {
            self.likes = likesDicts.flatMap({Like(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
        } else {
            self.likes = []
        }
    }
}

func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.username == rhs.username && lhs.uid == rhs.uid
}



























