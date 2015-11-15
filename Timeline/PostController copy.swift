//
//  PostController.swift
//  TimeLine
//
//  Created by Taylor Petersen on 11/4/15.
//  Copyright © 2015 Maverick. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    static func fetchTimelineForUser(user: User, completion: (posts: [Post]?) -> Void) {
        completion(posts: mockPosts())
        
    }
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        
        ImageController.uploadImage(image) { (identifier) -> Void in
            
            if let identifier = identifier {
                var post = Post(imageEndpoint: identifier, caption: caption)
                post.save()
                completion(success: true, post: post)
            } else {
                completion(success: false, post: nil)
            }
        }
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
        FirebaseController.dataAtEndpoint("post/\(identifier)") { (data) -> Void in
            
            if let data = data as? [String: AnyObject] {
                let post = Post(json: data, identifier: identifier)
                
                completion(post: post)
            } else {
                completion(post: nil)
            }
        }
    }
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let postDictionaries = snapshot.value as? [String: AnyObject] {
                
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
                
                let orderedPosts = orderPosts(posts)
                
                completion(posts: orderedPosts)
                
            } else {
                completion(posts: nil)
            }
        })
    }
    
    static func deletePost(post: Post, completion: (success: Bool) -> Void) {
        post.delete()
    }
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void?) {
        if let postIdentifier = post.identifier {
            
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: postIdentifier)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        } else {
            
            var post = post
            post.save()
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: post.identifier!)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        }
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        comment.delete()
        
        PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        if let postIdentifier = post.identifier {
            
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: postIdentifier)
            like.save()
            
        } else {
            
            var post = post
            post.save()
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: post.identifier!)
            like.save()
        }
        
        PostController.postFromIdentifier(post.identifier!) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        like.delete()
        
        PostController.postFromIdentifier(like.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func orderPosts(posts: [Post]) -> [Post] {
        
        return posts.sort({$0.0.identifier > $0.1.identifier})
        
    }
    
    static func mockPosts() -> [Post] {
        
        let sampleImageIdentifier = "-K1l4125TYvKMc7rcp5e"
        
        let like1 = Like(username: "blaine", postIdentifier: "1234")
        let like2 = Like(username: "holly", postIdentifier: "4566")
        let like3 = Like(username: "drake", postIdentifier: "43212")
        
        let comment1 = Comment(username: "taylor", text: "nice pic", postIdentifier: "1234")
        let comment2 = Comment(username: "blaine", text: "yeah it was a great shot", postIdentifier: "4566")
        
        let post1 = Post(imageEndpoint: sampleImageIdentifier, caption: "Love the Pic", username: "kelsi:", comments: [comment1, comment2], likes: [like1, like2, like3])
        let post2 = Post(imageEndpoint: sampleImageIdentifier, caption: "Great Pic", username: "taylor", comments: [], likes: [])
        let post3 = Post(imageEndpoint: sampleImageIdentifier, caption: "You're a professional", username: "blaine", comments: [], likes: [])
        
        return [post1, post2, post3]
    }

}