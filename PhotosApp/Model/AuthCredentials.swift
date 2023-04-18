//
//  AuthCredentials.swift
//  PhotosApp
//
//  Created by Wallace Santos on 27/03/23.
//let credentials = AuthCredentials(email: email, fullname: fullname, username: username, password: password, profileImage: image)

import UIKit

struct AuthCredentials{
    let email:String
    let password:String
    let fullname:String
    let username:String
    let profileImage:UIImage
    
    init(email: String, fullname: String, username: String, password:String,  profileImage: UIImage) {
        self.email = email
        self.password = password
        self.fullname = fullname
        self.username = username
        self.profileImage = profileImage
    }
}
