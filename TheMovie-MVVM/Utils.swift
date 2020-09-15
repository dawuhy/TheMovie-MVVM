//
//  Utils.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation
import UIKit

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

func getUrlImage(path: String?) -> URL {
    if path != nil {
        return URL(string: "https://image.tmdb.org/t/p/w500\(path!)")  ?? URL(string: "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png")!
    } else {
        return URL(string: "https://i0.wp.com/floor-design.jp/wp-content/uploads/2020/05/placeholder.png?fit=1200%2C800&ssl=1")!
    }
}

extension UIImageView {
    func loadImageFromPath(path: String?) {
        let queue = DispatchQueue(label: "queue")
        queue.async {
            do {
                let data = try Data(contentsOf: getUrlImage(path: path))
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
}
