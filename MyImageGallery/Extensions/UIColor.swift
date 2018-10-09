//
//  UIColor.swift
//  MyImageGallery
//
//  Created by RGhate on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

extension UIColor {
    
//    static let appThemeColor = rgb(red: 127, green: 218, blue: 214)

    static let appThemeColor = rgb(red: 208, green: 2, blue: 27)
    
    static let placeholderBackgroundColor = rgb(red: 230, green: 230, blue: 230)
    
    /**
     Convert red, green blue value to UIColor object
     
     @param red - CGFloat value of red
     @param green - CGFloat value of green
     @param blue - CGFloat value of blue
     */
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

