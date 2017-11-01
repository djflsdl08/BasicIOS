//
//  PhotoStore.swift
//  Photorama
//
//  Created by 김예진 on 2017. 10. 31..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import Foundation

class PhotoStore {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    //func fetchRecentPhotos() {
    func fetchRecentPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotosURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            /*
            if let jsonData = data {
                /*
                if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print(jsonString)
                }
                */
                do {
                    let jsonObject =  try JSONSerialization.jsonObject(with: jsonData, options: [])
                    print(jsonObject)
                }
                catch let error {
                    print("Error creating JSON object: \(error)")
                }
            } else if let requestError = error {
                print("Error fetching recent photos: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }*/
            
            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume()   // Start a Web service request.
    }
    
    func processRecentPhotosRequest(data:Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photosFromJSONData(data: jsonData)
    }
}

