//
//  SignupViewModel.swift
//  PhotosApp
//
//  Created by Wallace Santos on 22/03/23.
//

import Foundation


struct SignupViewModel {
    var email:String?
    var password:String?
    var fullname:String?
    var username:String?
    
    var formIsValid:Bool{
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
}
