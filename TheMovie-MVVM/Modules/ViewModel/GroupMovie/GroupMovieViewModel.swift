//
//  GroupMovieViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

class GroupMovieViewModel {
    
    struct Input {
        var receivedDataAction: ((MovieResult) -> Void)?
    }
    
    struct Output {
        var getMovieAction: ((Int, MovieType) -> Void)?
    }
    
    private let service = MovieServie()
    var input: Input?
    
    func bindAction(input: GroupMovieViewModel.Input) -> GroupMovieViewModel.Output {
        self.input = input
        
        let getMovie: ((Int, MovieType) -> Void)? = { [weak self] (page, type) in
            self?.getMovie(page: page, type: type)
        }
        
       return Output(getMovieAction: getMovie)
    }

    private func getMovie(page: Int, type: MovieType) {
        service.getMovies(page: page, typeMovie: type) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movieResult):
                self?.input?.receivedDataAction?(movieResult)
            }
        }
    }
    
    deinit {
        print("GroupMovieViewModel deinit")
    }
}
