//
//  MyImageGalleryTests.swift
//  MyImageGalleryTests
//
//  Created by Abhirup on 27/09/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import XCTest
@testable import MyImageGallery

class APIServiceManagerTests: XCTestCase {

    func testPageNumber() {
        let invalidPageNumber = -2

        let errForInvalid = APIServiceManager.shared.getPictures(forCategory: .top, showViralImages: false, pageNumber: invalidPageNumber) { (_, _) in
        }
        
        XCTAssertNotNil(errForInvalid)    //err should not be nil as the pageNumber passed is invalid
        
        let validPageNumber = 1
        
        let errForValid = APIServiceManager.shared.getPictures(forCategory: .top, showViralImages: false, pageNumber: validPageNumber) { (_, _) in
        }
        
        XCTAssertNil(errForValid)    //err should be nil as all the parameters (including pageNumber) passed are valid
    }
}
