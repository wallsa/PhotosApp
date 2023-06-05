//
//  SideMenuViewHeader.swift
//  PhotosApp
//
//  Created by Wallace Santos on 25/05/23.
//

import UIKit
import SDWebImage

class SideMenuViewHeader:UIView{
    
//MARK: - Properties
    
    private var user : User
    
    private let userImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = UIColor.darkPurple.cgColor
        imageView.layer.borderWidth = 4
        imageView.setDimensions(height: 80, width: 80)
        imageView.layer.cornerRadius = 80 / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userFullnameLabel:UILabel = {
        let label = UILabel()
        label.font = .normalBold
        return label
    }()
    
    private let userUsernameLabel:UILabel = {
        let label = UILabel()
        label.font = .normalBold
        return label
    }()

//MARK: - Lifecycle
    
    init(user:User, frame: CGRect) {
        self.user = user
        super.init(frame: frame)
        configure()
        configureData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
//MARK: - API

//MARK: - Helper Functions
    
    fileprivate func configure(){
        configureGradientLayer(colorOne: .darkPurple, colorTwo: .lightPurple)
        addSubview(userImageView)
        userImageView.anchor(top: topAnchor, paddingTop: AppSettings.Layout.mediumSpacing)
        userImageView.centerX(inview: self)
        
        addSubview(userFullnameLabel)
        userFullnameLabel.anchor(top: userImageView.bottomAnchor, paddingTop: AppSettings.Layout.defaultSpacing)
        userFullnameLabel.centerX(inview: self)
        
        addSubview(userUsernameLabel)
        userUsernameLabel.anchor(top: userFullnameLabel.bottomAnchor, paddingTop: AppSettings.Layout.defaultSpacing)
        userUsernameLabel.centerX(inview: self)
    }
    
    func configureGradientLayer(colorOne:UIColor, colorTwo:UIColor){
        let gradient = CAGradientLayer()
        gradient.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradient.locations = [0, 1]
        gradient.frame.size = bounds.size
        self.layer.addSublayer(gradient)
    }
    
    fileprivate func configureData(){
        //criar viewmodel
        userImageView.sd_setImage(with: user.profileImageURL)
        userFullnameLabel.text = user.fullname
        userUsernameLabel.text = "@\(user.username.lowercased())"
    }

//MARK: - Selectors
    
}
