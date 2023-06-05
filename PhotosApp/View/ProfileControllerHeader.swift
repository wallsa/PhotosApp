//
//  ProfileControllerHeader.swift
//  PhotosApp
//
//  Created by Wallace Santos on 29/05/23.
//

import UIKit

class ProfileControllerHeader:UICollectionReusableView{
    
//MARK: - Properties
    
    var user:User?{
        didSet{
            configureWithUser()
        }
    }
    
    private let filterBar = ProfileFilterHeaderView()
    
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
    
    private let postsLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSAttributedString().attributedTextForPostsAndFollowers(withNumber: "5", andText: "posts")
        label.attributedText = attributedText
        return label
    }()
    
    private let followesLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSAttributedString().attributedTextForPostsAndFollowers(withNumber: "12", andText: "followers")
        label.attributedText = attributedText
        return label
    }()
    
    private let followingLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSAttributedString().attributedTextForPostsAndFollowers(withNumber: "12", andText: "following")
        label.attributedText = attributedText
        return label
    }()
    
    private let editProfileButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = .normalBold
        button.addTarget(self , action: #selector(editProfileTapped), for: .touchUpInside)
        return button
    }()
    
//MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - API

//MARK: - Helper Functions
    
    func configure(){
        addSubview(userImageView)
        userImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: AppSettings.Layout.defaultSpacing, paddingLeft: AppSettings.Layout.defaultSpacing)
        
        let stack = UIStackView(arrangedSubviews: [postsLabel, followesLabel, followingLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: userImageView.rightAnchor, right: rightAnchor, paddingTop: AppSettings.Layout.defaultSpacing, paddingLeft: AppSettings.Layout.mediumSpacing, paddingRight: AppSettings.Layout.mediumSpacing, height: 50)
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: stack.bottomAnchor, left: stack.leftAnchor, right: rightAnchor, paddingTop: AppSettings.Layout.defaultSpacing,
                                 paddingLeft: AppSettings.Layout.defaultSpacing, paddingRight: AppSettings.Layout.mediumSpacing, height: 30)
        
        addSubview(userFullnameLabel)
        userFullnameLabel.anchor(top: editProfileButton.bottomAnchor, left: leftAnchor, paddingTop: AppSettings.Layout.defaultSpacing, paddingLeft: AppSettings.Layout.defaultSpacing)
        
        addSubview(filterBar)
        filterBar.delegate = self
        filterBar.anchor(top: userFullnameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: AppSettings.Layout.defaultSpacing, height: 50)

    }
    
    func configureWithUser(){
        userImageView.sd_setImage(with: user?.profileImageURL)
        userFullnameLabel.text = user?.fullname
    }

//MARK: - Selectors
    
    @objc func editProfileTapped(){
        print("DEBUG: EDDIT PROFILE IN HEADER")
    }
}

//MARK: - FilterHeadeView Delegate

extension ProfileControllerHeader:ProfileFilterHeaderViewDelegate{
    func selectFilter(at index: IndexPath) {
        //delega para o controller
        print("DEBUG: Select index at filterview \(index.row)")
    }
    
    
}

