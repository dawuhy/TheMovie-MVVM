//
//  TrailerMovie.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/14/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

struct TrailerMovie: Decodable {
    let key: String?
}

struct TrailerMovieResult: Decodable {
    let id: Int
    let results: [TrailerMovie]
}
