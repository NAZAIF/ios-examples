//
//  TMDb Client.swift
//  TMDb
//
//  Created by Moideen Nazaif VM on 16/07/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import Foundation

class TMDbClient {
    
    
    enum Endpoints {
        static let BaseUrl = "https://api.themoviedb.org/3"
        
        
        case popularPath
        case posterPath(String)
        
        var stringValue: String {
            switch self {
            case .popularPath:
                return Endpoints.BaseUrl + "/movie/popular?api_key=25daa653111cda6ea58bab897cb0ace3&language=en-US&page=1"
                
            
            case .posterPath(let posterPath):
                return "https://image.tmdb.org/t/p/w500" + posterPath
                
            }
        }
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
    }
    
    class func getPopularMoviePosters(completion: @escaping ([PopularMovieResult], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.popularPath.url) {(data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(PopularRequest.self, from: data)
                completion(responseObject.results, nil)
            }catch {
                completion([], error)
            }
            
        }
        
        task.resume()
    }
    
}
