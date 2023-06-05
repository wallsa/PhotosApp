//
//  ProfileFilterCell.swift
//  PhotosApp
//
//  Created by Wallace Santos on 01/06/23.
//

import UIKit

class ProfileFilterCell:UICollectionViewCell{
    
//MARK: - Properties
    
    var option:ProfileFilterOptions?{
        didSet{
            guard let option = option else {return}
            imageView.image = UIImage(systemName: option.image)
        }
    }
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .lightGray
        imageView.setDimensions(height: 25, width: 25)
        return imageView
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
            imageView.tintColor = isSelected ? .darkPurple : .lightGray
        }
    }
    
//MARK: - API

//MARK: - Helper Functions
    
    fileprivate func configure(){
        addSubview(imageView)
        imageView.centerX(inview: self)
        imageView.centerY(inview: self)
    }

//MARK: - Selectors
}
