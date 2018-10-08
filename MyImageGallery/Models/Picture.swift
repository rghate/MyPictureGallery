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
    let type: String
    let views: UInt
    let width: Int?
    let height: Int?
    let uploadDate: Date
    let inMostViral: Bool

//    init(link: String, description: String, type: String?, views: Int?, width: Int?, height: Int?) {
//        self.link = link
//        self.description = description
//        self.type = type
//        self.views = views
//        self.width = width
//        self.height = height
//        self.uploadDate =
//    }

    init?(dictionary: [String: Any]) {
        guard let link = dictionary["link"] as? String else { return nil }
        
        //return if image type is 'video'
        guard let type = dictionary["type"] as? String, type.lowercased().range(of: "video") == nil else { return nil }
        
        self.link = link
        self.description = dictionary["description"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.views = dictionary["views"] as? UInt ?? 0
        self.width = dictionary["width"] as? Int
        self.height = dictionary["height"] as? Int

        let secondsFrom1970 = dictionary["datetime"] as? Double ?? 0
        self.uploadDate = Date(timeIntervalSince1970: secondsFrom1970)
        
        self.inMostViral = dictionary["in_most_viral"] as? Bool ?? false

//        print("Link: ", self.link)
//        print("type: ", self.type)
//        print("views: ", self.views)
//        print("uploadDate: ", self.uploadDate)
//        print("inMostViral: ", self.inMostViral)
        for d in dictionary {
            print("\(d.key) : \(d.value)")
        }
        print("===================================")
    }
}

