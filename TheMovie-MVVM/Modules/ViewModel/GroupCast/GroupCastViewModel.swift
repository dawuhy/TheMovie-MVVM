//
//  CastViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/15/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

class GroupCastViewModel {
    typealias ReceivedDataAction = (CastResult) -> Void
    typealias GetCastsAction = (Int) -> Void
    
    struct Input {
        var receivedDataAction: ReceivedDataAction?
    }
    
    struct Output {
        var getCastsOf: GetCastsAction?
    }
    
    private let service = MovieServie()
    var input: Input?
    
    func bindAction(input: GroupCastViewModel.Input) -> GroupCastViewModel.Output {
        self.input = input
        
        let getCasts: GetCastsAction? = { [weak self] (movieID) in
            self?.getCastsOf(movieID: movieID)
        }
        
       return Output(getCastsOf: getCasts)
    }

    private func getCastsOf(movieID: Int) {
        service.getCastOf(movieID: movieID) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let castResult):
                self?.input?.receivedDataAction?(castResult)
            }
        }
    }
    
    deinit {
        print("GroupCastViewModel deinit")
    }
}
