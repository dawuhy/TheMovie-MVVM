//
//  MovieAPI.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation
import Moya

enum MovieAPI {
    case getMovies(page: Int, type: MovieType)
    case getMovieTrailer(movieId: Int)
    case getTrendingMovies
    case searchMovie(movieName:String)
    case getSimilarMovies(movieId: Int, page:Int)
    case searchPeople(name: String)
    case getCasts(movieID: Int)
    case getGuestSessionID
    case ratingMovie(guestSessionID: String, movieID: Int, point: Double)
    case getRatedMovies(guestSessionID: String)
    case deleteMovieRating(guestSessionID: String, movieID: Int)
}

extension MovieAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .getMovies(_, let type):
            return "/movie/\(type)"
        case .getMovieTrailer(let movieId):
            return "/movie/\(movieId)/videos"
        case .getTrendingMovies:
            return "/trending/movie/day"
        case .searchMovie:
            return "/search/movie"
        case .getSimilarMovies(movieId: let movieId, page: _):
            return "/movie/\(movieId)/similar"
        case .searchPeople:
            return "/search/person"
        case .getCasts(movieID: let movieID):
            return "/movie/\(movieID)/credits"
        case .getGuestSessionID:
            return "/authentication/guest_session/new"
        case .ratingMovie(guestSessionID: _, movieID: let movieID, point: _):
            return "/movie/\(movieID)/rating"
        case .getRatedMovies(guestSessionID: let guestSessionID):
            return "/guest_session/\(guestSessionID)/rated/movies"
        case .deleteMovieRating(guestSessionID: _, movieID: let movieID):
            return "/movie/\(movieID)/rating"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovies:
            return .get
        case .getMovieTrailer:
            return .get
        case .getTrendingMovies:
            return .get
        case .searchMovie:
            return .get
        case .getSimilarMovies:
            return .get
        case .searchPeople:
            return .get
        case .getCasts:
            return .get
        case .getGuestSessionID:
            return .get
        case .ratingMovie:
            return .post
        case .getRatedMovies(guestSessionID: _):
            return .get
        case .deleteMovieRating:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getMovies(let page, _):
            return .requestParameters(parameters: [ "page": "\(page)"], encoding: URLEncoding.default)
        case .getMovieTrailer:
            return .requestParameters(parameters: ["": ""], encoding: URLEncoding.default)
        case .getTrendingMovies:
            return .requestParameters(parameters: ["": ""], encoding: URLEncoding.default)
        case .searchMovie(movieName: let movieName):
            return .requestParameters(parameters: ["query": "\(movieName)"], encoding: URLEncoding.default)
        case .getSimilarMovies(movieId: let movieId, page: let page):
            return .requestParameters(parameters: ["movie_id": "\(movieId)", "page": "\(page)"], encoding: URLEncoding.default)
        case .searchPeople(name: let name):
            return .requestParameters(parameters: ["query": "\(name)"], encoding: URLEncoding.default)
        case .getCasts(movieID: _):
            return .requestParameters(parameters: ["": ""], encoding: URLEncoding.default)
        case .getGuestSessionID:
            return .requestParameters(parameters: ["": ""], encoding: URLEncoding.default)
        case .ratingMovie(guestSessionID: let guestSessionID, movieID: _, point: let point):
            return .requestCompositeParameters(bodyParameters: ["value": "\(point)"], bodyEncoding: JSONEncoding.default, urlParameters: ["api_key": "29d7a305994684a8d4d06303fcd07a4d", "guest_session_id": "\(guestSessionID)"])
        case .getRatedMovies(guestSessionID: _):
            return .requestParameters(parameters: ["sort_by": "created_at.desc"], encoding: URLEncoding.default)
        case .deleteMovieRating(guestSessionID: let guestSessionID, movieID: _):
            return .requestParameters(parameters: ["guest_session_id": "\(guestSessionID)"], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json;charset=utf-8"]
    }
}
