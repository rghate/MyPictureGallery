//
//  Constants.swift
//  MyImageGallery
//
//  Created by Abhirup on 04/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation

class Constants {
    enum LayoutType: String {
        case grid
        case list
        case masonry
        
        func type() -> String {
            return self.rawValue
        }
    }
    
    static let clientID = "be6fa0182c58fec"
}
