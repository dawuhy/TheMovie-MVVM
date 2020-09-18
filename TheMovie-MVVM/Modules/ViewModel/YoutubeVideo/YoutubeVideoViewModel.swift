//
//  YoutubeVideoVideoModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/14/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

class YoutubeVideoViewModel {
    
    typealias ReceivedDataAction = (TrailerMovieResult) -> Void
    typealias LoadDataAction = (Int) -> Void
    
    struct Input {
        var receivedDataAction: ReceivedDataAction?
    }
    
    struct Output {
        var loadDataAction: LoadDataAction?
    }
    
    private let service = MovieServie()
    var input: Input?

    private func getIDTrailerVideo(movieID: Int) {
        service.getIDTrailerVideo(movieID: movieID) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let trailerVideoResult):
                self.input?.receivedDataAction?(trailerVideoResult)
            }
        }
    }
    
    func bindAction(input: YoutubeVideoViewModel.Input) -> YoutubeVideoViewModel.Output {
        self.input = input

        let loadDataAction: LoadDataAction? = { [weak self] (movieID) in
            self?.getIDTrailerVideo(movieID: movieID)
        }
        
        return Output(loadDataAction: loadDataAction)
    }
    
    deinit {
        print("YoutubeVideoVideoModel deinit")
    }
}
