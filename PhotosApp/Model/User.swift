//
//  User.swift
//  PhotosApp
//
//  Created by Wallace Santos on 24/05/23.
//

import Foundation
import Firebase

struct User{
    
    let email:String
    let fullname:String
    var profileImageURL:URL?
    let uid:String
    let username:String
    var userStats:UserStats?
    
    var isFollowed:Bool = false
    
    var isCurrentUser:Bool{return Auth.auth().currentUser?.uid == uid}
    
    init(userdictionary:[String:Any]) {
        self.email = userdictionary["email"] as? String ?? ""
        self.fullname = userdictionary["fullname"] as? String ?? ""
        self.uid = userdictionary["uid"] as? String ?? ""
        self.username = userdictionary["username"] as? String ?? ""
        
        if let urlString = userdictionary["profileImageUrl"] as? String {
            if let url = URL(string: urlString){
                self.profileImageURL = url
            }
        }
    }
}

struct UserStats {
    var followers:Int
    var following:Int
}
