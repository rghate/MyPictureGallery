//
//  UIImageView.swift
//  MyImageGallery
//
//  Created by RGhate on 09/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    /**
     SDWebImage method to download and set image.
     
     @Param - url of the image to be downloaded.
     */
    func loadImage(with url: URL) {
        sd_setImage(with: url) { [weak self](_, err, _, _) in
            if err != nil {
                //if failed to download, set degault background color to show as image placeholder
                self?.backgroundColor = .placeholderBackgroundColor
                print("Failed for: ", url)
            } else {
                //if image set successfully, clear background color
                self?.backgroundColor = .clear
            }
        }
    }
}
