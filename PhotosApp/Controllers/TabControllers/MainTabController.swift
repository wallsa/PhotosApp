//
//  HomeController.swift
//  PhotosApp
//
//  Created by Wallace Santos on 23/05/23.
//

import UIKit
import Firebase

class MainTabController:UITabBarController{
    
//MARK: - Properties

//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUser()
        configureTabBarAppearance()
        configureViewControllers()
    }

//MARK: - API
    func fetchUser(_ uid: String) {
        print("DEBUG: USER UID IS \(uid)")
        UserService.fetchUser(forUID: uid) { user in
            print("DEBUG: USER IS \(user)")
        }
    }
    
    func loggoutUser(){
        do {
            try Auth.auth().signOut()
        }
        catch{
            print("DEBUG: Loggout Error")
        }
        presentLoginScreen()
    }

//MARK: - Helper Functions
    
    func checkUser(){
        if Auth.auth().currentUser?.uid == nil {
            print("DEBUG: User not connected, show loginCOntroller")
            presentLoginScreen()
        } else {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            fetchUser(uid)
        }
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
    
    func configureViewControllers(){
        let homeController = templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.home), rootViewController:  HomeViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        let searchController = templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.search), rootViewController: SearchController())
        let postController = templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.upload), rootViewController: PostController())
        let notificationController = templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.notifications), rootViewController: NotificationsController())
        let profileController = templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.profile), rootViewController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        viewControllers = [homeController, searchController, postController, notificationController, profileController]
        tabBar.barTintColor = .black
    }
    
    
    func templateNavController(image: UIImage? = nil, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        return nav
    }
    
    func configureTabBarAppearance() {
        if #available(iOS 15.0, *){
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.tintColor = .black
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    

//MARK: - Selectors
    
}

extension MainTabController:AuthenticationDelegate{
    func authenticateComplete(forUid uid: String) {
        print("the user login has this UID \(uid)")
    }
    
    
}
