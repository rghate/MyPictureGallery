//
//  APIService.swift
//  MyImageGallery
//
//  Created by RGhate on 04/10/18.
//

import Foundation
import Alamofire

class APIClient {
    
    //public method
    func fetch(url: URL, headers: [String: String], parameters: [String: Any], completion: @escaping ((
        DataResponse<Any>))->Void) {
        
        // Alamofire get request
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (responseData) in
            completion(responseData)
        }
    }
}
