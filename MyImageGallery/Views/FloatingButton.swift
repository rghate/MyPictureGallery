//
//  FloatingButton.swift
//  MyImageGallery
//
//  Created by Abhirup on 07/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.appThemeColor
        layer.cornerRadius = 35
        layer.masksToBounds = false
        layer.shadowColor = UIColor(white: 0, alpha: 0.7).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1.0
        tintColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    func disable() {
        tintColor = .lightGray
        isUserInteractionEnabled = false
    }

    func enable() {
        tintColor = .white
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
