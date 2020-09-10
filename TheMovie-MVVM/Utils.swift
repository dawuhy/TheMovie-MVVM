//
//  Utils.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

let APIKey = "29d7a305994684a8d4d06303fcd07a4d"

enum MovieType {
    case now_playing
    case popular
    case top_rated
    case similar
    
    func title() -> String {
        switch self {
        case .now_playing:
            return "Now playing"
        case .popular:
            return "Popular"
        case .top_rated:
            return "Top rated"
        case .similar:
            return "Similar movies"
        }
    }
}
