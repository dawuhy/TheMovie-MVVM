//
//  Utils.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit
import RealmSwift

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
        return URL(string: "https://image.tmdb.org/t/p/w500\(path!)")!
    } else {
        return URL(string: "https://bigocoder.com/image/default_avatar.jpg")!
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

var listFavoriteMovie: Results<FavoriteMovieObject>!
var listFavoriteMovieId:[Any] = []
