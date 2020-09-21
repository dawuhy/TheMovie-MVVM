//
//  RatingMovieViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/21/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

class RatingMovieViewModel {
    struct Input {
        var receiveDataAction: ((RatingMovieResponse) -> Void)?
    }
    
    struct Output {
        var ratingMovie: ((String, Int, Double) -> Void)?
    }
    
    private let service = MovieServie()
    var input: Input?
    
    func bindAction(input: RatingMovieViewModel.Input) -> RatingMovieViewModel.Output {
        self.input = input
        
        let ratingMovie: ((String, Int, Double) -> Void)? = { [weak self] (guestSessionID, movieID, point) in
            guard let self = self else {return}
            self.ratingMovie(guestSessionID: guestSessionID, movieID: movieID, point: point)
        }
        
       return Output(ratingMovie: ratingMovie)
    }
    
    private func ratingMovie(guestSessionID: String, movieID: Int, point: Double) {
        service.ratingMovie(guestSessionID: guestSessionID, movieID: movieID, point: point) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print(error)
            case .success(let ratingMovieResponse):
                self.input?.receiveDataAction?(ratingMovieResponse)
            }
        }
    }
}
