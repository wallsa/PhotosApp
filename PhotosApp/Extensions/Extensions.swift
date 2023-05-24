//
//  Extensions.swift
//  PhotosApp
//
//  Created by Wallace Santos on 22/03/23.
//

import UIKit
import JGProgressHUD

//MARK: - UIView

extension UIView{
    
    func loginContainer(image: String, textfield:UITextField, showPassButton:UIButton? = nil) -> UIView{
        let view = UIView()
        let imageView = UIImageView()
        let image = UIImage(systemName: image)
        imageView.tintColor = .white
        imageView.image = image
        
        view.addSubview(imageView)
        imageView.centerY(inview: view)
        imageView.anchor(left: view.leftAnchor, paddingLeft: 4, width: 24, height: 24)
        
        if let showPassButton = showPassButton{
            view.addSubview(showPassButton)
            showPassButton.anchor(right: view.rightAnchor, paddingRight: 4)
            showPassButton.centerY(inview: view)
        }

        view.addSubview(textfield)
        textfield.centerY(inview: view)
        if textfield.isSecureTextEntry{
            textfield.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right:showPassButton?.leftAnchor,  paddingLeft: 8, paddingRight: 8)
        }else{
            textfield.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right:view.rightAnchor, paddingLeft: 8, paddingRight: 8)
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .white
        view.addSubview(separatorView)
        separatorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 0.75)
        view.anchor(height: 50)
        return view
    }
}
//MARK: - Text Field
extension UITextField {
    func createLoginTextField(placeholder:String, isSecure:Bool, keyboardType:UIKeyboardType) -> UITextField{
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .white
       
        textField.isSecureTextEntry = isSecure
        textField.keyboardType = keyboardType
        textField.keyboardAppearance = .dark
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return textField
    }
}

//MARK: - Attributed String

extension NSAttributedString{
    
    func attributedText(withText text:String, andBoldText text2:String, color:UIColor) -> NSAttributedString{
        let title = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor:color])
        let action = NSAttributedString(string: " \(text2)", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor:color])
        title.append(action)
        return title
    }
    
}
//MARK: - View Controller

extension UIViewController{

    func configureGradientLayer(colorOne:UIColor, colorTwo:UIColor){
        let gradient = CAGradientLayer()
        gradient.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradient.locations = [0, 1]
        gradient.borderColor = UIColor.red.cgColor
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    
    static let HUD = JGProgressHUD(style: .dark)
    
    func showHUD(_ show:Bool ,with text: String? = "Loading") {
        view.endEditing(true)
        UIViewController.HUD.textLabel.text = text
        
        show ? UIViewController.HUD.show(in: view) : UIViewController.HUD.dismiss()
    }

    
    
    func configureNavigationBar(withTitle title:String, color:UIColor, largeTitle:Bool){
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = color
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = largeTitle
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
}

//MARK: - Alert Controller

extension UIAlertController {
    func createSimpleAlert(title:String, message:String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        return alert
    }
    
    func createLogoutAlert(completion: @escaping (UIAlertAction) -> ()) -> UIAlertController{
        let alert = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: completion))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        return alert
    }
}


