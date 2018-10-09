//
//  UILabel.swift
//  MyImageGallery
//
//  Created by RGhate on 29/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

extension UILabel {
    /**
     Calculate label height based on text, width of label and font size
     
     @param string - label text data
     @param width - label width
     @param font - label font
     
     @Returns - height for the label
     */
    class func height(for string: String, width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.font = font
        label.text = string
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label.frame.height
    }
}
