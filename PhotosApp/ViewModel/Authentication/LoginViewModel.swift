//
//  LoginViewModel.swift
//  PhotosApp
//
//  Created by Wallace Santos on 22/03/23.
//

import Foundation


struct LoginViewModel {
    var email:String?
    var password:String?
    
    var formIsValid:Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
