//
//  Cast.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/15/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

struct Cast: Decodable {
    let castID: Int
    let character: String
    let creditID: String
    let gender: Int?
    let id: Int
    let name: String
    let order: Int
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender
        case id
        case name
        case order
        case profilePath = "profile_path"
    }
}

struct CastResult: Decodable {
    let id: Int
    let cast: [Cast]
}
