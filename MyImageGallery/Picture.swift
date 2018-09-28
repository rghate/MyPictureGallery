//
//  Picture.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation

struct Picture {
//    let id: String? //TODO: required??
    
    let imageUrl: String
    let description: String?
    
    init(imageUrl: String, description: String?) {
        self.imageUrl = imageUrl
        self.description = description
    }
}
