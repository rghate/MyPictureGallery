//
//  APIServiceManager.swift
//  MyImageGallery
//
//  Created by Abhirup on 08/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation

class APIServiceManager {
    
    //singleton
    static let shared = APIServiceManager()
    
    private init() { }
    
    private let baseUrlString = "https://api.imgur.com/3/gallery/"
    
    func getPictures(forCategory category: Constants.ImageCategory, showViralImages: Bool, pageNumber: Int, completion: @escaping ((error: CustomError?, pictures: [Picture]))->Void ) {
        
        var responseError: CustomError?
        
        let pictures = [Picture]()
        let window = "day"
        let sortBy = showViralImages ? "viral" : "time" //if viral enabled, request sortedby viral, else by time
        
        print("Image category - ", category.rawValue)
        print("show viral - ", showViralImages)

        //construct complete url
        let urlStr = "\(baseUrlString)/\(category.rawValue)/\(sortBy)/\(window)/\(pageNumber)"

        //if invalid url, return with error
        guard let url = URL(string: urlStr) else {
            responseError = CustomError(description: "Invalid url")
            return completion((error: responseError, pictures: pictures))
        }

        let parameters = ["showViral": "\(showViralImages)"]

        APIService.shared.fetch(url: url, parameters: parameters, completion: completion)
        
    }
}
