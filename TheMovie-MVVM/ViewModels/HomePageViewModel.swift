//
//  HomePageViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

typealias ReceivedDataAction = (MovieResult) -> Void
typealias LoadDataAction = (_ page: Int, _ movieType: MovieType) -> Void

class HomePageViewModel {
    
    struct Input {
        var callBackGetMovieAction: ReceivedDataAction?
    }
    
    struct Output {
        var getMovieAction: LoadDataAction?

    }
    
    private let service = MovieServie()
    var input: Input?
//    var output: Output?
    
    func bindAction(input: HomePageViewModel.Input) -> HomePageViewModel.Output {
        self.input = input
        
        let loadDataAction: ((Int, MovieType) -> Void)? = { [weak self] (page, type) in
            self?.getMovie(page: page, type: type)
        }
        
        return Output(getMovieAction: loadDataAction)
    }

    private func getMovie(page: Int, type: MovieType) {
        service.getMovies(page: page, typeMovie: type) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movieResult):
                self?.input?.callBackGetMovieAction?(movieResult)
            }
        }
    }
}
