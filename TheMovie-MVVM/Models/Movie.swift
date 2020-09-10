//
//  Movie.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation
//import RealmSwift

struct Movie: Decodable {
    var id:Int
    var posterPath:String?
    var backdropPath:String?
    var title:String?
    var releaseDate:String?
    var rating:Float
    var overview:String
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
    }
    
//    init(movieObject: MovieObject) {
//        self.id = movieObject.id
//        self.posterPath = movieObject.posterPath
//        self.backdropPath = movieObject.backdropPath
//        self.title = movieObject.title
//        self.releaseDate = movieObject.releaseDate
//        self.rating = movieObject.rating
//        self.overview = movieObject.overview
//    }
}

struct MovieResult: Decodable {
    var page:Int
    var totalResult:Int
    var totalPages:Int
    var arrayMovie: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResult = "total_results"
        case totalPages = "total_pages"
        case arrayMovie = "results"
    }
}
