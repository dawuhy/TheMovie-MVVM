//
//  Cast.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/15/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

struct Cast: Decodable {
    let cast_id: Int
    let character: String
    let credit_id: String
    let gender: Int?
    let id: Int
    let name: String
    let order: Int
    let profile_path: String?
}

struct CastResult: Decodable {
    let id: Int
    let cast: [Cast]
}
