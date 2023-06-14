//
//  ProfileController.swift
//  PhotosApp
//
//  Created by Wallace Santos on 24/05/23.
//

import UIKit
import Firebase

fileprivate let reuseIdentifier = "Cell"
fileprivate let headerIdentifier = "Header"

class ProfileController: UICollectionViewController {
//MARK: - Properties
    
    private var user:User{
        didSet{
            collectionView.reloadData()
        }
    }
    
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
        checkIfUserIfFollow()
        fetchUserStats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserStats()
    }
    
//MARK: - API
    
    func fetchUser(forUid uid:String){
        UserService.fetchUser(forUID: uid) { user in
            self.user = user
            self.collectionView.reloadData()
        }
    }
    
    func checkIfUserIfFollow(){
        UserService.checkIfUserIsFollowed(uid: user.uid) { isFollowing in
            self.user.isFollowed = isFollowing
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats(){
        UserService.fetchUserStats(withUid: user.uid) { stats in
            self.user.userStats = stats
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
        header.delegate = self
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
//MARK: - Profile Header Delegate

extension ProfileController:ProfileHeaderDelegate{
    func followOrUnfollowPressed() {
        if user.isFollowed{
            UserService.unfollowUser(uid: user.uid) { error , dataref in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        }else {
            UserService.followUser(uid: user.uid) { error , dataref in
                self.user.isFollowed = true
                self.collectionView.reloadData()
                //Implementar notificação para o usuario
            }
        }
    }
    
    func editProfilePressed() {
        print("DEBUG: EDIT PROFILE IN CONTROLLER")
    }
}
