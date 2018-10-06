//
//  Picture.swift
//  MyImageGallery
//
//  Created by Abhirup on 28/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation

struct Picture: Decodable {
    let link: String
    let description: String
    let type: String?
    let views: Int?
    let width: Int?
    let height: Int?
    
    init(link: String, description: String, type: String?, views: Int?, width: Int?, height: Int?) {
        self.link = link
        self.description = description
        self.type = type
        self.views = views
        self.width = width
        self.height = height
    }
    
    init?(dict: [String: Any]) {
        guard let link = dict["link"] as? String else { return nil }
        
        //return if image type is 'video'
        guard let type = dict["type"] as? String, type.lowercased().range(of: "video") == nil else { return nil }
        
        self.link = link
        self.description = dict["description"] as? String ?? ""
        self.type = dict["type"] as? String
        self.views = dict["views"] as? Int
        self.width = dict["width"] as? Int
        self.height = dict["height"] as? Int
    }
}

