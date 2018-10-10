//
//  PictureTests.swift
//  MyImageGalleryTests
//
//  Created by Abhirup on 10/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import XCTest
@testable import MyImageGallery

class PictureTests: XCTestCase {
    var dictionary: [String: Any]?
    
    let link = "testlink.com"
    let type = "test video"
    let desc = "test description"
    let numberOfViews: UInt = 1
    let width = 100
    let height = 150
    let secondsFrom1970: Double = Date().timeIntervalSince1970
    let inMostViral = true
    
    override func setUp() {
        self.dictionary = ["link": link,
                      "type": type,
                      "description": desc,
                      "views": numberOfViews,
                      "width": width,
                      "height": height,
                      "datetime": secondsFrom1970,
                      "in_most_viral": inMostViral]
    }
    
    override func tearDown() {
        self.dictionary?.removeAll()
    }
    
    func testPicturePositiveInitialization() {
        guard let dictionary = self.dictionary else { return }
        let pictureObj = Picture(dictionary: dictionary)
        
        XCTAssertNotNil(pictureObj) //fails if nil
        
        XCTAssertEqual(link, pictureObj?.link)
        XCTAssertEqual(type, pictureObj?.type)
        XCTAssertEqual(desc, pictureObj?.description)
        XCTAssertEqual(numberOfViews, pictureObj?.views)
        XCTAssertEqual(width, pictureObj?.width)
        XCTAssertEqual(height, pictureObj?.height)
        
        let dateVal = Date(timeIntervalSince1970: secondsFrom1970)
        XCTAssertEqual(dateVal, pictureObj?.uploadDate)
        
        XCTAssertEqual(inMostViral, pictureObj?.inMostViral)
    }
    
    
    func testPictureNegativeInitialization() {
        //picture should not be initialized if the its type is video
        
        if var dictionary = self.dictionary {
            let typeAsVideo = "video/mp4"
            dictionary.updateValue(typeAsVideo, forKey: "type")
            
            let pictureObj = Picture(dictionary: dictionary)
            
            XCTAssertNil(pictureObj)    //fails if not nil
        }
    }
}
