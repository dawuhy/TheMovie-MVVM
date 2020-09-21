//
//  HomePageViewModel.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/18/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation
import KeychainSwift

class HomePageViewModel {

    struct Input {
        var receiveDataAction: ((GuestSessionIDResult) -> Void)?
    }
    
    struct Output {
        var getGuestSessionID: (() -> Void)?
    }
    
    let service = MovieServie()
    var input:Input?
    private let keychain = KeychainSwift()
    
    func bindAction(input: HomePageViewModel.Input) -> HomePageViewModel.Output {
        self.input = input
        
        let getGuestSessionID: (() -> Void)? = { [weak self] in
            self?.getGuestSessionID()
        }
        
        return Output(getGuestSessionID: getGuestSessionID)
    }
    
    private func getGuestSessionID() {
        service.getGuestSessionID { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let guestSessionIDResult):
                self?.input?.receiveDataAction?(guestSessionIDResult)
            }
        }
    }
}
