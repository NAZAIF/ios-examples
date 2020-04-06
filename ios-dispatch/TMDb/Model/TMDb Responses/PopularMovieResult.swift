//
//  PopularMovieResult.swift
//  TMDb
//
//  Created by Moideen Nazaif VM on 16/07/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import Foundation

struct PopularMovieResult: Codable {
    let posterPath: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
    }
}
