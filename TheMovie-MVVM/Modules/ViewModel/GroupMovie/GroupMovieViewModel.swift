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
    var getMovieAction: ((_ page: Int, _ movieType: MovieType) -> Void)!
    var callBackMovieAction: ((MovieResult) -> Void)!
    
    init() {
        getMovieAction = { [weak self] (page, movieType) in
            guard let self = self else {return}
            self.getMovie(page: page, movieType: movieType)
        }
    }

    private func getMovie(page: Int, movieType: MovieType) {
        service.getMovies(page: page, typeMovie: movieType) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movieResult):
//                self?.input?.callBackMovieAction?(movieResult)
                self?.callBackMovieAction(movieResult)
            }
        }
    }
    
    func completionHandler(_ callBackMovieAction: @escaping (MovieResult) -> Void) {
        self.callBackMovieAction = callBackMovieAction
    }
    
    deinit {
        print("GroupMovieViewModel deinit")
    }
}
