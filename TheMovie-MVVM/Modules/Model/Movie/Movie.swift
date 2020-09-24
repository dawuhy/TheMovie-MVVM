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
    let id:Int
    let posterPath:String?
    let backdropPath:String?
    let title:String
    let releaseDate:String
    let voteAverage:Float
    let voteCount: Int
    let overview:String
    var ratingOfUser: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case overview
        case ratingOfUser = "rating"
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
