//
//  UIView.swift
//  MyImageGallery
//
//  Created by RGhate on 29/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

extension UIView {
    
    //helper method for setting anchor constraints of the view
    
    /**
     Set anchor constraints of the view to position it with respec to the related view
     
     @param top - layout attribute represented by the YAxis anchor w.r.t. the related view. Optional.
     @param left - layout attribute represented by the XAxis anchor w.r.t. the related view. Optional.
     @param bottom - layout attribute represented by the YAxis anchor w.r.t. the related view. Optional.
     @param right - layout attribute represented by the XAxis anchor w.r.t. the related view. Optional.
     
     @param paddingTop - constant top padding w.r.t. the relative view
     @param paddingLeft - constant left padding w.r.t. the relative view
     @param paddingBottom - constant bottom padding w.r.t. the relative view
     @param paddingRight - constant right padding w.r.t. the relative view
     
     @param width - view width
     @param width - view height
     
     */
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false

        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
