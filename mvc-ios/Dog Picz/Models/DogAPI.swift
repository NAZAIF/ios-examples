//
//  DogAPI.swift
//  Dog Picz
//
//  Created by Moideen Nazaif VM on 25/06/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    enum EndPoint {
        case randomDogImage
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            
            case .randomDogImage:
                return "https://dog.ceo/api/breeds/image/random"
                
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            }
        }
    }
    
    class func requestAllBreeds(completionHandler: @escaping ([String], Error?) -> Void) {
        let getAllBreedsURL = DogAPI.EndPoint.listAllBreeds.url
        
        let getBreedsTask = URLSession.shared.dataTask(with: getAllBreedsURL) {(data, response, error) in
            guard let data = data, error == nil else {
                completionHandler([], error)
                return
            }
            
            let decoder = JSONDecoder()
            let responseData = try! decoder.decode(DogBreeds.self, from: data)
            let breeds = responseData.message.keys.map({$0})
            completionHandler(breeds, nil)
            
        }
        
        getBreedsTask.resume()
        
    }
    
    class func requestRandomImageFor(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageURL = DogAPI.EndPoint.randomImageForBreed(breed).url
        
        let imageDataTask = URLSession.shared.dataTask(with: randomImageURL) { (data, response, error) in
            guard let data = data else {
                print(error!.localizedDescription)
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            print(imageData)
            completionHandler(imageData, nil)
        }
        imageDataTask.resume()
        
    }
    
    class func getImageFromNetwork(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let imageRetrievalTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                print(error!.localizedDescription)
                completionHandler(nil, error)
                return
            }
            completionHandler(image, nil)
        }
        imageRetrievalTask.resume()
    }
    
}
