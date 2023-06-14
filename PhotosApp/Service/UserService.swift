//
//  UserService.swift
//  PhotosApp
//
//  Created by Wallace Santos on 24/05/23.
//

import Foundation
import Firebase

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

struct UserService{
    
    static func fetchUser(forUID uid:String, completion:@escaping (User) ->()){
        USERS_REF.child(uid).observeSingleEvent(of: .value) { datasnap in
            let dictionary = datasnap.value as! [String:Any]
            let user = User(userdictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion:@escaping([User]) -> ()){
        var users = [User]()
        
        USERS_REF.observe(.childAdded) { datasnap in
            guard let dictionary = datasnap.value as? [String:Any] else {return}
            let user = User(userdictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
    
    static func fetchUserStats(withUid uid:String, completion:@escaping (UserStats) -> ()){
        USERS_FOLLOWERS.child(uid).observe(.value) { followersDatasnap in
            let followers = followersDatasnap.children.allObjects.count
            
            USERS_FOLLOWING.child(uid).observe(.value) { followingDatasnap in
                let following = followingDatasnap.children.allObjects.count
                completion(UserStats(followers: followers, following: following))
            }
        }
    }
    
    static func followUser(uid:String, completion:@escaping(DatabaseCompletion)){
        guard let currentUID = Auth.auth().currentUser?.uid else {return}
        
        USERS_FOLLOWING.child(currentUID).updateChildValues([uid:1]) { error , dataref in
            USERS_FOLLOWERS.child(uid).updateChildValues([currentUID:1], withCompletionBlock: completion)
        }
    }
    
    static func unfollowUser(uid:String, completion:@escaping(DatabaseCompletion)){
        
        guard let currentUID = Auth.auth().currentUser?.uid else {return}
        
        USERS_FOLLOWING.child(currentUID).child(uid).removeValue { _, _ in
            USERS_FOLLOWERS.child(uid).child(currentUID).removeValue(completionBlock: completion)
        }
    }
    
    static func checkIfUserIsFollowed(uid:String, completion:@escaping(Bool) -> ()){
        guard let currentUID = Auth.auth().currentUser?.uid else {return}
        USERS_FOLLOWING.child(currentUID).child(uid).observeSingleEvent(of: .value) { datasnap in
            completion(datasnap.exists())
        }
    }
    
}
