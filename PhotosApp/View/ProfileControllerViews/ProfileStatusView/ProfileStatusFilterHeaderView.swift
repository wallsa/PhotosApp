//
//  ProfileStatusFilterView.swift
//  PhotosApp
//
//  Created by Wallace Santos on 20/06/23.
//

import UIKit

private let profileStatusFilterCell = "profileStatusFilterCell"

protocol ProfileStatusFilterHeaderViewDelegate:AnyObject{
    func optionSelected(_ option:ProfileStatusFilterOptions)
}

enum ProfileStatusFilterOptions:Int, CustomStringConvertible, CaseIterable{
    case followers
    case following
    
    var description: String {
        switch self {
        case .followers: return "Followers"
        case .following: return "Following"
        }
    }
}

class ProfileStatusFilterHeaderView:UIView{
    
//MARK: - Properties
    
    weak var delegate:ProfileStatusFilterHeaderViewDelegate?
    
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let underLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let selectedLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkPurple
        return view
    }()
    
//MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(selectedLineView)
        selectedLineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width/CGFloat(ProfileStatusFilterOptions.allCases.count), height: 2)
    }
     
//MARK: - Helper Functions
    fileprivate func configure(){
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor , right: rightAnchor, paddingTop: 1 , paddingBottom: 1)
        collectionView.register(ProfileStatusFilterCell.self, forCellWithReuseIdentifier: profileStatusFilterCell)
        
        addSubview(underLineView)
        underLineView.anchor(top: collectionView.bottomAnchor, left: leftAnchor, right: rightAnchor , height: 0.5)
    }
    
    fileprivate func animateUnderline(forCell cell:UICollectionViewCell){
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.selectedLineView.frame.origin.x = xPosition
        }
    }
    
    func animateUnderlineForSecondCell(){
        let index = IndexPath(row: 1, section: 0)
        if let cell = collectionView.cellForItem(at: index){
            let xPosition = cell.frame.origin.x
            UIView.animate(withDuration: 0.3) {
                self.selectedLineView.frame.origin.x = xPosition
            }
        }
    }
    
    
//MARK: - Selectors
    
}


//MARK: - UICollectionView Delegate and DataSource
extension ProfileStatusFilterHeaderView:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileStatusFilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileStatusFilterCell, for: indexPath) as! ProfileStatusFilterCell
        cell.option = ProfileStatusFilterOptions(rawValue: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        guard let option = ProfileStatusFilterOptions(rawValue: indexPath.row) else {return}
        animateUnderline(forCell: cell)
        delegate?.optionSelected(option)
    }
}

//MARK: - Collection View Dimensions

extension ProfileStatusFilterHeaderView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(Int(ProfileStatusFilterOptions.allCases.count)), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
