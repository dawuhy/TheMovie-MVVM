//
//  RatingMovieViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/21/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

class RatingMovieViewModel {
    private let service = MovieServie()
    
    // Input
    private var ratingMovieCallBackAction: ((RatingMovieStatus) -> Void)?
    private var deleteMovieRatingCallBackAction: ((RatingMovieStatus) -> Void)?
    // Output
    var ratingMovieAction: ((_ guestSessionID: String, _ movieID: Int, _ point: Double) -> Void)!
    var deleteMovieRatingAction: ((_ guestSessionID: String, _ movieID: Int) -> Void)!
    
    init() {
        ratingMovieAction = { [weak self] (guestSessionID, movieID, point) in
            self?.ratingMovie(guestSessionID: guestSessionID, movieID: movieID, point: point)
        }
        
        deleteMovieRatingAction = { [weak self] (guestSessionID, movieID) in
            self?.deleteMovieRating(guestSessionID: guestSessionID, movieID: movieID)
        }
    }
    
    // Completion handler
    public func ratingMovieCompletionHandler(_ ratingMovieCallBackAction: @escaping (RatingMovieStatus) -> Void) {
        self.ratingMovieCallBackAction = ratingMovieCallBackAction
    }
    
    public func deleteMovieRatingCompletionHandler(_ deleteMovieRatingCallBackAction: @escaping (RatingMovieStatus) -> Void) {
        self.deleteMovieRatingCallBackAction = deleteMovieRatingCallBackAction
    }
    
    private func ratingMovie(guestSessionID: String, movieID: Int, point: Double) {
        service.ratingMovie(guestSessionID: guestSessionID, movieID: movieID, point: point) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print(error)
            case .success(let ratingStatusResponse):
                self.ratingMovieCallBackAction?(ratingStatusResponse)
            }
        }
    }
    
    private func deleteMovieRating(guestSessionID: String, movieID: Int) {
        service.deleteMovieRating(guestSessionID: guestSessionID, movieID: movieID) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let ratingStatusResponse):
                self.deleteMovieRatingCallBackAction?(ratingStatusResponse)
            }
        }
    }
    
    deinit {
        print("RatingMovieViewModel deinit")
    }
}
