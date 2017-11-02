//
//  PhotoStore.swift
//  Photorama
//
//  Created by 김예진 on 2017. 10. 31..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(Error)
}

enum PhotoError: Error {
    case ImageCreationError
}

class PhotoStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        
        return URLSession(configuration: config)
    }()
    
    //func fetchInterstringPhotos() {
    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.interestingPhotosURL
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
            
            let result = self.processPhotosRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()   // Start a Web service request.
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void) {
        
        if let image = photo.image {
            completion(.Success(image))
            return
        }

        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func processPhotosRequest(data:Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photos(fromJSON: jsonData)
    }
    
    func processImageRequest(data:Data?, error: Error?) -> ImageResult {
        guard let imageData = data,
              let image = UIImage(data: imageData) else {
                if data == nil {
                    return .Failure(error!)
                } else {
                    return .Failure(PhotoError.ImageCreationError)
                }
        }
        return .Success(image)
    }
}

