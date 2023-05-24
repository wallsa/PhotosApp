//
//  User.swift
//  PhotosApp
//
//  Created by Wallace Santos on 24/05/23.
//

import Foundation

struct User{
    
    let email:String
    let fullname:String
    var profileImageURL:URL?
    let uid:String
    let username:String
    
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
