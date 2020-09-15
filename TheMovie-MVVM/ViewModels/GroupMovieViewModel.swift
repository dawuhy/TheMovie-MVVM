//
//  GroupMovieViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation



class GroupMovieViewModel {
    
    typealias ReceivedDataAction = (MovieResult) -> Void
    typealias LoadDataAction = (Int, MovieType) -> Void
    
    struct Input {
        var receivedDataAction: ReceivedDataAction?
    }
    
    struct Output {
        var loadDataAction: LoadDataAction?
    }
    
    private let service = MovieServie()
    var input: Input?
    
    func bindAction(input: GroupMovieViewModel.Input) -> GroupMovieViewModel.Output {
        self.input = input
        
        let loadDataAction: LoadDataAction? = { [weak self] (page, type) in
            self?.getMovie(page: page, type: type)
        }
        
       return Output(loadDataAction: loadDataAction)
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
