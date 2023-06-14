//
//  SearchProfilesCell.swift
//  PhotosApp
//
//  Created by Wallace Santos on 05/06/23.
//

import UIKit

class SearchProfilesCell:UITableViewCell{
    //MARK: - Properties
    
    var user:User?{
        didSet{
            setUser()
        }
    }
    
    private let userImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = UIColor.darkPurple.cgColor
        imageView.layer.borderWidth = 4
        imageView.setDimensions(height: 50, width: 50)
        imageView.layer.cornerRadius = 50 / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel:UILabel = {
        let label = UILabel()
        label.font = .normalBold
        return label
    }()
    
    private let fullnameLabel:UILabel = {
        let label = UILabel()
        label.font = .normal
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API
    
    //MARK: - Helper Functions
    
    fileprivate func configure(){
        addSubview(userImageView)
        userImageView.centerY(inview: self, leftAnchor: leftAnchor, paddinLeft: AppSettings.Layout.defaultSpacing)
        
        let nameStack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        nameStack.axis = .vertical
        nameStack.distribution = .fillEqually
        addSubview(nameStack)
        nameStack.centerY(inview: self, leftAnchor: userImageView.rightAnchor, paddinLeft: AppSettings.Layout.defaultSpacing)
    }
    
    fileprivate func setUser(){
        userImageView.sd_setImage(with: user?.profileImageURL)
        usernameLabel.text = user?.username
        fullnameLabel.text = user?.fullname
    }
    
    //MARK: - Selectors
}
