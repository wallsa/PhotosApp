//
//  ProfileController.swift
//  PhotosApp
//
//  Created by Wallace Santos on 24/05/23.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifier = "Header"

class ProfileController: UICollectionViewController {
//MARK: - Properties
    
    private var user:User
    
//MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUser()
    }
    
//MARK: - API
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.fetchUser(forUID: uid) { user in
            self.user = user
        }
    }
    
//MARK: - Helper Functions
    
    func configureCollectionView(){
        collectionView.register(ProfileControllerHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
//MARK: - Selectors
   
    
}

//MARK: - CollectionView DataSource and Delegate
extension ProfileController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .darkPurple
        return cell
    }
}

//MARK: - CollectionView Header

extension ProfileController{
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileControllerHeader
        header.user = user
        return header
    }
}
//MARK: - CollectionViewController - Size for Header and Cells

extension ProfileController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: AppSettings.Layout.defaultSpacing, left: AppSettings.Layout.defaultSpacing, bottom: AppSettings.Layout.defaultSpacing, right: AppSettings.Layout.defaultSpacing)
    }
}
