//
//  APIService.swift
//  MyImageGallery
//
//  Created by Abhirup on 04/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation
import Alamofire
import ImgurSession

class APIService {
    
    //singleton
    static let shared = APIService()
    
    //MARK:- private variables
    
    private let baseUrlString = "https://api.imgur.com/3/gallery/top"
    
    private init() {
        
    }
    
    //MARK:- Public methods
    
    func fetch(completion: @escaping ((error: Error?, pictures: [Picture]))->Void) {
        
        let parameters: Parameters = ["showViral": "true"]
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(Constants.clientID)"
        ]
        
        var pictures = [Picture]()
        var responseError: CustomError?

        guard let url = URL(string: baseUrlString) else {
            responseError = CustomError(localizedDescription: "Invalid url")
            return completion((error: responseError, pictures: pictures))
        }

        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { /*[weak self]*/ (responseData) in
            
            if let err = responseData.error {
                responseError = CustomError(localizedDescription: err.localizedDescription)
                return completion((error: responseError, pictures: pictures))
            }
            
            guard let json = responseData.result.value as? [String: Any], let dataDictArr = json["data"] as? [[String: Any]] else {
                let error = CustomError(localizedDescription: "Invalid response data")
                return completion((error, pictures: pictures))
            }
            
            for item in dataDictArr {
                guard let images = item["images"] as? [[String: Any]] else { continue }
                
                for image in images {
                    if let picture = Picture(dict: image) {
                        pictures.append(picture)
                    }
                }
            }
            completion((nil, pictures: pictures))
        }
    }

}
