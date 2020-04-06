//
//  APIService.swift
//  CoreDataTutorial
//
//  Created by Moideen Nazaif VM on 04/06/19.
//  Copyright © 2019 James Rochabrun. All rights reserved.
//

import UIKit

class APIService: NSObject {
    let query = "dogs"
    lazy var endPoint : String = {
        return "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=\(self.query)&nojsoncallback=1#"
    }()
    
    func getDataWith(completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        guard let url = URL(string: endPoint) else { return completion(.Error("Invalid URL. Can't update the field."))}
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            guard error == nil else { return completion(.Error(error!.localizedDescription))}
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new items to show")) }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String : AnyObject] {
                    guard let itemsJsonArray = json["items"] as? [[String: AnyObject]] else { return }
                    DispatchQueue.main.async {
                        completion(.Success(itemsJsonArray))
                    }
                }
            }catch let error {
                return completion(.Error(error.localizedDescription))
            }
        }.resume()
        
        
    }

}

enum Result <Y> {
    case Success(Y)
    case Error(String)
}
