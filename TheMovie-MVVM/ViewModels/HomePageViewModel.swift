//
//  HomePageViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation


class HomePageViewModel {
 
    private let service = MovieServie()
    var callBackAction: ((MovieResult) -> Void)?
    var getMovieAction: ((Int, MovieType) -> Void)?
    
    init() {
        getMovieAction = { [weak self] (page, movieType) in
            self?.getMovie(page: page, type: movieType)
        }
    }
    
    func registerActions(_ reloadData: ((MovieResult) -> Void)?) {
        self.callBackAction = reloadData
    }
    
    private func getMovie(page: Int, type: MovieType) {
        service.getMovies(page: page, typeMovie: type) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movieResult):
                self.callBackAction?(movieResult)
            }
        }
    }
    
    deinit {
        print("HomePageViewModel deinit")
    }
}
