//
//  HomeViewController.swift
//  PhotosApp
//
//  Created by Wallace Santos on 24/05/23.
//

import UIKit
import SideMenu
import Firebase

private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {

//MARK: - Properties
    
    private var user:User{
        didSet{
            print(user)
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
        configureNaviBar()
    }
    
//MARK: - API
    
    func fetchUser(_ uid: String){
        UserService.fetchUser(forUID: uid) { user in
            print("DEBUG: USER IS \(user)")
            self.user = user
        }
    }
    
    func logoutUser(){
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch let error {
            print("DEBUG: Failed to signOut with error ... \(error.localizedDescription)")
        }
    }
    
//MARK: - Helper Functions
    
    func configureNaviBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sidebar.squares.left"), style: .done, target: self, action: #selector(handleSidemenu))
        navigationItem.title = "Teste"
        navigationController?.navigationBar.tintColor = .darkPurple
    }

    func presentLoginScreen(){
        DispatchQueue.main.async {
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
//MARK: - Selectors
    
    @objc func handleSidemenu(){
        let sideMenu = SideMenuController(user: user)
        let menu = SideMenuNavigationController(rootViewController: sideMenu)
        menu.leftSide = true
        sideMenu.delegate = self
        menu.presentationStyle = .viewSlideOutMenuIn
        present(menu, animated: true)
    }
}

//MARK: - Log In / Sign In Authenticate

extension HomeViewController:AuthenticationDelegate{
    func authenticateComplete(forUid uid: String) {
        print("DEBUG: AUTHENTICATE COMPLETE")
        dismiss(animated: true)
        fetchUser(uid)
    }
}

//MARK: - SideMenuDelegate

extension HomeViewController:SideMenuDelegate{
    func sideMenuOptionPressed(_ option: SideMenuOptions) {
        dismiss(animated: true)
        switch option{
        case .options:
            print("DEBUG: ProfileOptions Pressed")
        case .loggout:
            print("DEBUG: Loggout Pressed")
            let alert = UIAlertController().createLogoutAlert { loggout in
                self.logoutUser()
            }
            present(alert, animated: true)
        }
    }
}


