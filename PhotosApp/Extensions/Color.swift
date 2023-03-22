//
//  Color.swift
//  PhotosApp
//
//  Created by Wallace Santos on 22/03/23.
//

import UIKit

extension UIColor{
    
    static func rgb(red: CGFloat, green : CGFloat, blue:CGFloat) -> UIColor{
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
    static let navyBlue = UIColor.rgb(red: 15, green: 98, blue: 146)
    static let mainPurple = UIColor.rgb(red: 57, green: 48, blue: 83)
    static let darkPurple = UIColor.rgb(red: 55, green: 27, blue: 88)
    static let mediumPurple = UIColor.rgb(red: 76, green: 53, blue: 117)
    static let softPurple = UIColor.rgb(red: 91, green: 75, blue: 138)
    static let lightPurple = UIColor.rgb(red: 120, green: 88, blue: 166)
   
}
