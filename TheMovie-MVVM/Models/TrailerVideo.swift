//
//  TrailerMovie.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/14/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

struct TrailerVideo: Decodable {
    let key: String?
}

struct TrailerVideoResult: Decodable {
    let id: Int
    let results: [TrailerVideo]
}
