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
    
    private var user:User

//MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUser()
        configureTabBarAppearance()
        configureViewControllers()
    }

//MARK: - API
    func fetchUser(_ uid: String) {
        UserService.fetchUser(forUID: uid) { user in
            print("DEBUG: USER IS \(user)")
            self.user = user
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
        let homeController = UINavigationController().templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.home), rootViewController:  HomeViewController(user: user))
        let searchController = UINavigationController().templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.search), rootViewController: SearchController())
        let postController = UINavigationController().templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.upload), rootViewController: PostController())
        let notificationController = UINavigationController().templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.notifications), rootViewController: NotificationsController())
        let profileController = UINavigationController().templateNavController(image: UIImage(systemName: AppSettings.TabBarImages.profile), rootViewController: ProfileController(user: user))
        
        viewControllers = [homeController, searchController, postController, notificationController, profileController]
    }
    
    func configureTabBarAppearance() {
        if #available(iOS 15.0, *){
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.tintColor = .darkPurple
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
//MARK: - Authentication Login Delegate
extension MainTabController:AuthenticationDelegate{
    func authenticateComplete(forUid uid: String) {
        print("the user login has this UID \(uid)")
    }
}
