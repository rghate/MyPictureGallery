//
//  APIService.swift
//  MyImageGallery
//
//  Created by Abhirup on 04/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    func fetch(url: URL, headers: [String: String], parameters: [String: Any], completion: @escaping ((
        DataResponse<Any>))->Void) {

        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (responseData) in
            completion(responseData)
        }
    }
}
