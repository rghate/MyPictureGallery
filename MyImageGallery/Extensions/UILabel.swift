//
//  UILabel.swift
//  MyImageGallery
//
//  Created by Abhirup on 29/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

extension UILabel {
    class func height(for string: String, width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.font = font
        label.text = string
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label.frame.height
    }
}
