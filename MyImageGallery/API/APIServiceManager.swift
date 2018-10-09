//
//  APIServiceManager.swift
//  MyImageGallery
//
//  Created by RGhate on 08/10/18.
//

import Foundation

final class APIServiceManager {
    
    //singleton
    static let shared = APIServiceManager()

    //Private variables
    private let httpClient = APIClient()
    private let baseUrlString = "https://api.imgur.com/3/gallery/"

    private enum Window {
        static let day = "day"
        static let all = "all"
    }
    
    private enum SortBy {
        static let viral = "viral"
        static let time = "time"
    }
    
    private enum Headers {
        static let authorization = "Authorization"
    }

    private enum Params {
        static let showViral = "showViral"
    }
    
    //private method(s)
    private init() { }

    
    //public method(s)
    func getPictures(forCategory category: Constants.ImageCategory, showViralImages: Bool, pageNumber: Int,
                     completion: @escaping ((error: CustomError?, pictures: [Picture]))->Void ) {
        
        
        print("Viral ", showViralImages)
        
        print("Viral ", category.rawValue)
        
        let window = Window.all

        //if viral enabled, request sortedby viral, else by time
        let sortBy = showViralImages ? SortBy.viral : SortBy.time
        
        //construct complete url
        let urlStr = "\(baseUrlString)/\(category.rawValue)/\(sortBy)/\(window)/\(pageNumber)"

        let pictures = [Picture]()
        var responseError: CustomError?
        
        //if invalid url, return with error
        guard let url = URL(string: urlStr) else {
            responseError = CustomError(description: "Invalid url")
            return completion((error: responseError, pictures: pictures))
        }

        let headers: [String: String] = [
            Headers.authorization: "Client-ID \(Constants.clientID)"
        ]
        let params = [Params.showViral: "\(showViralImages)"]

        httpClient.fetch(url: url, headers: headers, parameters: params, completion: { responseData in
            if let err = responseData.error {
                responseError = CustomError(description: err.localizedDescription)
                return completion((responseError, pictures: pictures))
            }
            
            var pictures = [Picture]()
            
            //if failed to get data, return error back
            guard let json = responseData.result.value as? [String: Any], let dataDictArr = json["data"] as? [[String: Any]] else {
                responseError = CustomError(description: "Invalid response data")
                return completion((responseError, pictures: pictures))
            }
            
            for item in dataDictArr {
                guard let images = item["images"] as? [[String: Any]] else { continue }
                
                for image in images {
                    if let picture = Picture(dictionary: image) {
                        pictures.append(picture)
                    }
                }
            }
            completion((nil, pictures: pictures))
        })
        
    }
}
