//
//  CustomError.swift
//  MyImageGallery
//
//  Created by Abhirup on 04/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation

struct CustomError: LocalizedError {
    let localizedDescription: String
    
    init(description: String) {
        localizedDescription = description
    }
}
