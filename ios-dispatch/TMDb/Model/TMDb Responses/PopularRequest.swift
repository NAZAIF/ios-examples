//
//  PopularRequest.swift
//  TMDb
//
//  Created by Moideen Nazaif VM on 16/07/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import Foundation

struct PopularRequest: Codable {
    let results: [PopularMovieResult]
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalResults = "total_results"
    }
}
