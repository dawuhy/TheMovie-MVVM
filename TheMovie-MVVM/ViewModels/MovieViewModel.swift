////
////  MovieViewModel.swift
////  TheMovie-MVVM
////
////  Created by Huy on 9/10/20.
////  Copyright © 2020 nhn. All rights reserved.
////
//
//import Foundation
//
//class MovieViewModel {
//    var movies: [Movie] = []
//    var movieService = MovieServie()
//}
//
//extension MovieViewModel {
//    func getMovies(page: Int, movieType: MovieType, completion: @escaping (Result<[Movie], Error>) -> Void) {
//        movieService.getMovies(page: page, typeMovie: movieType) { (result) in
//            switch result {
//            case .success(let movieResult):
//                self.movies.append(contentsOf: movieResult.arrayMovie)
//                completion(.success(movieResult.arrayMovie))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
