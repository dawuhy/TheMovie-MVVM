//
//  MovieService.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation
import Moya

class MovieServie {
    var movieProvider: MoyaProvider<MovieAPI>
    
    init() {
        self.movieProvider = MoyaProvider<MovieAPI>(endpointClosure: { (target: TargetType) -> Endpoint in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: MultiTarget(target))
            switch defaultEndpoint.task {
            case .requestParameters(var params, let encoding):
                params["api_key"] = APIKey // this parameter should be passed to every request
                params["language"] = "en-US"
                return Endpoint(url: defaultEndpoint.url, sampleResponseClosure: defaultEndpoint.sampleResponseClosure, method: defaultEndpoint.method, task: .requestParameters(parameters: params, encoding: encoding), httpHeaderFields: defaultEndpoint.httpHeaderFields)
            default:
                break
            }
            return defaultEndpoint
        })
    }
    
    func getMovies(page: Int, typeMovie: MovieType, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        movieProvider.request(.getMovies(page: page, type: typeMovie)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let movieResult = try JSONDecoder().decode(MovieResult.self, from: response.data)
                    completion(.success(movieResult))
                    return
                } catch (let error) {
                    completion(.failure(error))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
    
    func getIDTrailerVideo(movieID: Int, completion: @escaping (Result<TrailerVideoResult, Error>) -> Void) {
        movieProvider.request(.getMovieTrailer(movieId: movieID)) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                return
            case .success(let response):
                do {
                    let trailerVideoResult = try JSONDecoder().decode(TrailerVideoResult.self, from: response.data)
                    completion(.success(trailerVideoResult))
                } catch (let error) {
                    completion(.failure(error))
                }
            }
        }
    }
}
