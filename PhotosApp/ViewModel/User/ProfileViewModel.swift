//
//  Profile.swift
//  PhotosApp
//
//  Created by Wallace Santos on 09/06/23.
//

import UIKit

struct ProfileViewModel {
    //MARK: - Properties
    
    private let user:User
    
    var userProfileImage:URL?{
        return user.profileImageURL
    }
    
    var userFullname:String{
        return user.fullname
    }
    
    var userUsername:String{
        return "@\(user.username)"
    }
    
    var actionButtonConfig:ProfileHeadeActionButtonConfig{
        if user.isCurrentUser{
            return .editProfile
        } else {
            return .followAndUnfollow
        }
    }
    
    var actionButtonTitle:String{
        if user.isCurrentUser{
            return "Edit Profile"
        }
        if !user.isFollowed && !user.isCurrentUser{
             return "Follow"
        }
        
        if user.isFollowed {
            return "Following"
        }
        return ""
    }
    
    var userFollowers:Int{
        return user.userStats?.followers ?? 0
    }
    
    var userFollowing:Int{
        return user.userStats?.following ?? 0
    }
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
    }

}
