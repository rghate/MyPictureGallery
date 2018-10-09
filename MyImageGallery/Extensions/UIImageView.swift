//
//  UIImageView.swift
//  MyImageGallery
//
//  Created by Abhirup on 09/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImage(with url: URL) {
        sd_setImage(with: url) { [weak self](_, err, _, _) in
            if err != nil {
                print("Failed for: ", url)
            } else {
                self?.backgroundColor = .clear
            }
        }
    }
}
