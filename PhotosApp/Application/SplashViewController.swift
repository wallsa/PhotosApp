//
//  SplashViewController.swift
//  PhotosApp
//
//  Created by Wallace Santos on 22/03/23.
//

import UIKit

class SplashViewController: UIViewController {
    //MARK: - Properties
        
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {1
                    let mainViewController = MainTabController()
                    UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: mainViewController)
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                 }
        }
        
       
        
    //MARK: - Helpers
        
        fileprivate func configure(){
            configureGradientLayer(colorOne: .darkPurple, colorTwo: .lightPurple)
            view.addSubview(centralLogo)
            centralLogo.centerX(inview: view)
            centralLogo.centerY(inview: view)
            
            
        }
   

}
