//
//  MovieDetailViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/23/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    let service = MovieServie()

    var getRatedMoviesAction: ((_ guestSessionID: String) -> Void)!
    private var callBackRatedMoviesAction: ((_ movieResult: MovieResult) -> Void)?
    public func getRatedMoviesCompletionHandler(_ callBackRatedMoviesAction: @escaping (_ movieResult: MovieResult) -> Void) {
        self.callBackRatedMoviesAction = callBackRatedMoviesAction
    }
    
    init() {
        getRatedMoviesAction = { [weak self] (guestSessionID) in
            self?.getRatedMovies(guestSessionID: guestSessionID)
        }
    }
    
    private func getRatedMovies(guestSessionID: String) {
        service.getRatedMovies(guestSessionID: guestSessionID) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movieResult):
                self.callBackRatedMoviesAction?(movieResult)
            }
        }
    }
}
