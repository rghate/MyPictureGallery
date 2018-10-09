//
//  Number.swift
//  MyImageGallery
//
//  Created by RGhate on 08/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation

extension UInt {

    /**
     Convert Int into decimal formatted string.
     e.g. "2 min ago" or "3 days ago"
     
     @Returns - decimal formatted string
     */
    func decimalFormat() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedString = numberFormatter.string(from: NSNumber(value:self))
        
        return formattedString
    }
}
