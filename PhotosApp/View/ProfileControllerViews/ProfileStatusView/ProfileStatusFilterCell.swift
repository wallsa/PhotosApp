//
//  ProfileStatusFilterCell.swift
//  PhotosApp
//
//  Created by Wallace Santos on 20/06/23.
//

import UIKit

class ProfileStatusFilterCell:UICollectionViewCell{
    
//MARK: - Properties
    
    var option:ProfileStatusFilterOptions?{
        didSet{
            guard let option = option else {return}
            optionLabel.text = option.description
        }
    }
    
    private let optionLabel:UILabel = {
        let label = UILabel()
        label.font = .normalMedium
        label.textAlignment = .center
        return label
    }()

//MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool{
        didSet{
            optionLabel.textColor = isSelected ? .darkPurple : .lightGray
            optionLabel.font = isSelected ? .mediumBold : .normalMedium
        }
    }
    
//MARK: - API

//MARK: - Helper Functions
    
    fileprivate func configure(){
        addSubview(optionLabel)
        optionLabel.centerX(inview: self)
        optionLabel.centerY(inview: self)
    }
}

