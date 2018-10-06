//
//  UIImageView.swift
//  MyImageGallery
//
//  Created by Abhirup on 06/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import UIKit


extension UIImageView {
    
    func setMediumImage(withUrlString string: String) {
        let modifiedUrlStr = modifyUrlForMediumSizedImage(urlString: string)
        
        guard let url = URL(string: modifiedUrlStr) else { return }
        
        //        sd_setImage(with: url)
        sd_setImage(with: url) { [weak self] (_, err, _, _) in
            if err != nil {
                print("Failed for: ", url)
            } else {
                self?.backgroundColor = .clear
            }
        }
    }
    
    /**
     Method to modify urlString to get medium sized image thumbnail instead of full sized image.
     This function appends a single character suffix ("m" for medium thumbnail) to the end
     of the image id, and before the file extension.
     
     For example, the image located at http://i.imgur.com/12345.jpg has the Medium Thumbnail located at http://i.imgur.com/12345m.jpg
     
     For more info check: https://api.imgur.com/models/image
     */
    
    private func modifyUrlForMediumSizedImage(urlString: String) -> String {
        var modifiedUrlStr = urlString
        //get last index of "." from usr-string
        if let lastIndex = urlString.lastIndex(of: ".") {
            modifiedUrlStr.insert("m", at: lastIndex)
        }
        return modifiedUrlStr
    }
    
    
    
    //    func modifyUrlForMediumSizedImage(urlString: String) -> String {
    //        var modifiedUrlStr = urlString
    //        //get last index of "." from usr-string
    //        if let lastIndex = urlString.lastIndex(of: ".") {
    //            //convert lastIndex into Int
    //            let indexVal = urlString.distance(from: urlString.startIndex, to: lastIndex)
    //
    //            //reduce indexVal by 1 to get the required position to insert char 'm'
    //            let requiredIndexVal = indexVal - 1
    //
    //            //convert required index int value to Index obj
    //            let insertionIndex = urlString.index(urlString.startIndex, offsetBy: requiredIndexVal)
    //
    //            if indexVal > 0 {
    //                modifiedUrlStr.insert("m", at: lastIndex)
    //            }
    //        }
    //        return modifiedUrlStr
    //    }
}
