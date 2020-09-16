//
//  HomePageViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

<<<<<<< HEAD
=======
typealias ReceivedDataAction = (MovieResult) -> Void
typealias LoadDataAction = (Int, MovieType) -> Void
>>>>>>> e8ce5a442a64c6c039c781958cc99f53a9b92e8e

class HomePageViewModel {
 
    private let service = MovieServie()
<<<<<<< HEAD
    private var receivedDataAction: ((MovieResult) -> Void)?
    var getMovie: ((Int, MovieType) -> Void)?
    
    init() {
        getMovie = { [weak self] (page, movieType) in
=======
    
    // Input
    private var receivedDataAction: ReceivedDataAction?
    // Output
    var loadDataAction: LoadDataAction?
    
    init() {
        loadDataAction = { [weak self] (page, movieType) in
>>>>>>> e8ce5a442a64c6c039c781958cc99f53a9b92e8e
            self?.getMovie(page: page, type: movieType)
        }
    }
    
    func registerActions(_ reloadData: ((MovieResult) -> Void)?) {
        self.receivedDataAction = reloadData
    }
    
    private func getMovie(page: Int, type: MovieType) {
        service.getMovies(page: page, typeMovie: type) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movieResult):
                self.receivedDataAction?(movieResult)
            }
        }
    }
    
    deinit {
        print("HomePageViewModel deinit")
    }
}
