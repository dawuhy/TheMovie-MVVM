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
        var getGuestSessionIDAction: (() -> Void)?
        var setUpGuestSessionIDAction: (() -> Void)?
    }
    
    let service = MovieServie()
    var input:Input?
    private let keychain = KeychainSwift()
    private var output: HomePageViewModel.Output?
    
    func bindAction(input: HomePageViewModel.Input) -> HomePageViewModel.Output {
        self.input = input
        
        let getGuestSessionIDAction: (() -> Void)? = { [weak self] in
            self?.getGuestSessionID()
        }
        
        let setUpGuestSessionIDAction: (() -> Void)? = { [weak self] in
            guard let self = self else {return}
            self.setUpGuestSessionID()
        }
        
        return Output(getGuestSessionIDAction: getGuestSessionIDAction, setUpGuestSessionIDAction: setUpGuestSessionIDAction)
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
    
    private func setUpGuestSessionID() {
        if keychain.get("session_id") == nil {
            output?.getGuestSessionIDAction?()
        }
        print("CURRENT SESSION ID: \(String(describing: keychain.get("session_id")))")
    }
}
