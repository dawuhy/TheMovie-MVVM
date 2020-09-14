//
//  HomePageViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

typealias ReceivedDataAction = (MovieResult) -> Void
typealias VoidAction = () -> Void

class HomePageViewModel {
 
    private let service = MovieServie()
    
    // Input
    private var receivedDataAction: ReceivedDataAction?
    // Output
    var loadDataAction: VoidAction?
    
    init() {
        loadDataAction = { [weak self] in
            self?.getMovie(page: 1, type: .popular)
        }
    }
    
    func registerActions(_ reloadData: ReceivedDataAction?) {
        self.receivedDataAction = reloadData
    }
    
    func getMovie(page: Int, type: MovieType) {
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
