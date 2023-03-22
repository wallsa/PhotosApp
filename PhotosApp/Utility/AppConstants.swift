//
//  AppConstants.swift
//  PhotosApp
//
//  Created by Wallace Santos on 22/03/23.
//

import UIKit


enum AppSettings {
    
    enum Layout {
        static let smallSpacing: Int   = defaultSpacing / 2
        static let defaultSpacing: Int = 8
        static let mediumSpacing: Int  = defaultSpacing * 2
        static let bigSpacing: Int     = defaultSpacing * 3
    }
    
    enum Images{
        static let camera = "camera.fill"
        static let eye = "eye.fill"
        static let personImage = "person.circle.fill"
        static let messageBaloon = "message"
        static let envelope = "envelope"
        static let lock = "lock"
        static let person = "person"
        static let personAdd = "person.crop.circle"
        static let plus = "plus"
    }
    
}

extension UIFont {
    // Default
    static let xsmall = UIFont.systemFont(ofSize: 10)
    static let small  = UIFont.systemFont(ofSize: 12)
    static let normal = UIFont.systemFont(ofSize: 14)
    static let medium = UIFont.systemFont(ofSize: 16)
    static let big    = UIFont.systemFont(ofSize: 18)
    static let xbig   = UIFont.systemFont(ofSize: 20)
    
    // Medium
    static let xsmallMedium = UIFont.systemFont(ofSize: 10, weight: .medium)
    static let smallMedium  = UIFont.systemFont(ofSize: 12, weight: .medium)
    static let normalMedium = UIFont.systemFont(ofSize: 14, weight: .medium)
    static let mediumMedium = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let bigMedium    = UIFont.systemFont(ofSize: 18, weight: .medium)
    static let xbigMedium   = UIFont.systemFont(ofSize: 20, weight: .medium)
    
    // Semibold
    static let xsmallSemibold = UIFont.systemFont(ofSize: 10, weight: .semibold)
    static let smallSemibold  = UIFont.systemFont(ofSize: 12, weight: .semibold)
    static let normalSemibold = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let mediumSemibold = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let bigSemibold    = UIFont.systemFont(ofSize: 18, weight: .semibold)
    static let xbigSemibold   = UIFont.systemFont(ofSize: 20, weight: .semibold)
    
    // Bold
    static let xsmallBold = UIFont.systemFont(ofSize: 10, weight: .bold)
    static let smallBold  = UIFont.systemFont(ofSize: 12, weight: .bold)
    static let normalBold = UIFont.systemFont(ofSize: 14, weight: .bold)
    static let mediumBold = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let bigBold    = UIFont.systemFont(ofSize: 18, weight: .bold)
    static let xbigBold   = UIFont.systemFont(ofSize: 20, weight: .bold)
}

