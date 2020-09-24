//
//  GroupMovieViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

class GroupMovieViewModel {
    
    private let service = MovieServie()
    var getMovieFromTypeAction: ((_ page: Int, _ movieType: MovieType) -> Void)!
    var getSimilarMovieAction: ((_ movieID: Int, _ page: Int) -> Void)!
    
    private var callBackGetMovieAction: ((MovieResult) -> Void)?
    private var callBackGetSimilarMovieAction: ((MovieResult) -> Void)?
    
    init() {
        getMovieFromTypeAction = { [weak self] (page, movieType) in
            guard let self = self else {return}
            self.getMovieFromType(page: page, movieType: movieType)
        }
        
        getSimilarMovieAction = { [weak self] (movieID, page) in
            guard let self = self else {return}
            self.getSimilarMovie(movieID: movieID, page: page)
        }
    }

    private func getMovieFromType(page: Int, movieType: MovieType) {
        service.getMovies(page: page, typeMovie: movieType) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movieResult):
                self?.callBackGetMovieAction?(movieResult)
            }
        }
    }
    
    private func getSimilarMovie(movieID: Int, page: Int) {
        service.getSimilarMovies(movieID: movieID, page: page) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movieResult):
                self?.callBackGetSimilarMovieAction?(movieResult)
            }
        }
    }
    
    func getMovieCompletionHandler(_ callBackGetMovieAction: @escaping (MovieResult) -> Void) {
        self.callBackGetMovieAction = callBackGetMovieAction
    }
    
    func getSimilarMovieCompletionHandler(_ callBackGetMovieAction: @escaping (MovieResult) -> Void) {
        self.callBackGetSimilarMovieAction = callBackGetMovieAction
    }
    
    deinit {
        print("GroupMovieViewModel deinit")
    }
}
