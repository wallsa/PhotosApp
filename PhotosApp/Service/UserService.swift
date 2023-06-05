//
//  UserService.swift
//  PhotosApp
//
//  Created by Wallace Santos on 24/05/23.
//

import Foundation
import Firebase


struct UserService{
    
    static func fetchUser(forUID uid:String, completion:@escaping (User) ->()){
        USERS_REF.child(uid).observeSingleEvent(of: .value) { datasnap in
            let dictionary = datasnap.value as! [String:Any]
            let user = User(userdictionary: dictionary)
            completion(user)
        }
        
    }
}
