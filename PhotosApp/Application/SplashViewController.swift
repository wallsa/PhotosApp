//
//  SplashViewController.swift
//  PhotosApp
//
//  Created by Wallace Santos on 22/03/23.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
//MARK: - Properties
    
    private var user:User?{
        didSet{
            configureMainTab()
        }
    }
        
    private let centralLogo: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "camera.fill")
            imageView.contentMode = .scaleAspectFill
            imageView.tintColor = .white
            imageView.setDimensions(height: 200, width: 200)
            return imageView
    }()
      
//MARK: - Lyfe Cycle
        
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        checkUser()
    }

//MARK: - API
    
    func fetchUser(_ uid: String){
        UserService.fetchUser(forUID: uid) { user in
            print("DEBUG: USER IS \(user)")
            self.user = user
        }
    }
        
   
//MARK: - Helpers
        
    fileprivate func configure(){
        configureGradientLayer(colorOne: .darkPurple, colorTwo: .lightPurple)
        view.addSubview(centralLogo)
        centralLogo.centerX(inview: view)
        centralLogo.centerY(inview: view)
    }
    
    fileprivate func configureMainTab() {
        guard let user = user else {return}
        let mainViewController = MainTabController(user: user)
        UIApplication.shared.windows.first?.rootViewController = mainViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
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
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
   

}
