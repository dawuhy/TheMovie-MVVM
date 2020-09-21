//
//  RatingMovie.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/21/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

struct RatingMovieResponse: Decodable {
    let success: Bool
    let status_code: Int
    let status_message: String
}
