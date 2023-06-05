//
//  ProfileFilterHeaderView.swift
//  PhotosApp
//
//  Created by Wallace Santos on 01/06/23.
//

import UIKit

protocol ProfileFilterHeaderViewDelegate:AnyObject{
    func selectFilter(at index:IndexPath)
}

private let reuseIdentifier = "ProfilefilterCell"

enum ProfileFilterOptions:Int,CustomStringConvertible, CaseIterable {
    case grid
    case list
    case bookmark
        
    var description: String{
        switch self {
        case .grid: return "Grid"
        case .list:return "List"
        case .bookmark:return "Bookmarks"
        }
    }
    
    var image: String{
        switch self {
        case .grid: return "square.grid.3x3.fill"
        case .list:return "list.bullet"
        case .bookmark:return "bookmark"
        }
    }
}

class ProfileFilterHeaderView:UIView{
    
    
//MARK: - Properties
    
    weak var delegate:ProfileFilterHeaderViewDelegate?
    
    lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private let underLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let backUnderLineView : UIView = {
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
    
    //como utilizamos os frame.width por conta do lifecycle temos que utilizar o layoutsubviews para acessa-lo no momento em que seu valor é igual o da tela
    override func layoutSubviews() {
        addSubview(selectedLineView)
        selectedLineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width/CGFloat(ProfileFilterOptions.allCases.count), height: 2)
    }
    
//MARK: - API

//MARK: - Helper Functions
    
    fileprivate func configure(){
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 1, paddingBottom: 1)
        collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        addSubview(underLineView)
        underLineView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 1, paddingRight: 1, height: 0.5)
        
        addSubview(backUnderLineView)
        backUnderLineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 1, paddingBottom: 1, paddingRight: 1, height: 0.5)
        
        
        let firstOption = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: firstOption, animated: true, scrollPosition: .left)
        
    }
   
    
    fileprivate func animateUnderline(forCell cell:UICollectionViewCell){
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.selectedLineView.frame.origin.x = xPosition
        }
    }

}


//MARK: - CollectionView DataSource and Delegate

extension ProfileFilterHeaderView:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileFilterCell
        let option = ProfileFilterOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        animateUnderline(forCell: cell)
        delegate?.selectFilter(at: indexPath)
    }
    
}

//MARK: - Collection View Dimensions

extension ProfileFilterHeaderView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(Int(ProfileFilterOptions.allCases.count)), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
