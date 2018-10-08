//
//  Number.swift
//  MyImageGallery
//
//  Created by Abhirup on 08/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation

extension UInt {
    func decimalFormat() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedString = numberFormatter.string(from: NSNumber(value:self))
        
        return formattedString
    }
}
