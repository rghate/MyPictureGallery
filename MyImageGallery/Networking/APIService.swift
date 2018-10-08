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

    private init() { }
    
    //MARK:- Public methods
    
    func fetch(url: URL, parameters: [String: Any], completion: @escaping ((error: CustomError?, pictures: [Picture]))->Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(Constants.clientID)"
        ]

        var pictures = [Picture]()
        var responseError: CustomError?
    
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { /*[weak self]*/ (responseData) in
            
            if let err = responseData.error {
                responseError = CustomError(description: err.localizedDescription)
                return completion((responseError, pictures: pictures))
            }

            guard let json = responseData.result.value as? [String: Any], let dataDictArr = json["data"] as? [[String: Any]] else {
                let error = CustomError(description: "Invalid response data")
                return completion((error, pictures: pictures))
            }

            for item in dataDictArr {
                guard let images = item["images"] as? [[String: Any]] else { continue }

                for image in images {
                    if let picture = Picture(dictionary: image) {
                        pictures.append(picture)
                    }
                }
            }
            print("********************** ", pictures.count)
            completion((nil, pictures: pictures))
        }
    }
    
}
