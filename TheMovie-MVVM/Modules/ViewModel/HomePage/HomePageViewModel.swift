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
    
    //    struct Input {
    //        var completionHandler: ((GuestSessionIDResult) -> Void)?
    //    }
    //
    //    struct Output {
    //        var getGuestSessionIDAction: (() -> Void)?
    //        var setUpGuestSessionIDAction: (() -> Void)?
    //    }
    
    //    private var output: HomePageViewModel.Output?
    
    //    func bindAction(input: HomePageViewModel.Input) -> HomePageViewModel.Output {
    //        self.input = input
    //
    //        let getGuestSessionIDAction: (() -> Void)? = { [weak self] in
    //            self?.getGuestSessionID()
    //        }
    //        let setUpGuestSessionIDAction: (() -> Void)? = { [weak self] in
    //            guard let self = self else {return}
    //            self.setUpGuestSessionID()
    //        }
    //        return Output(getGuestSessionIDAction: getGuestSessionIDAction, setUpGuestSessionIDAction: setUpGuestSessionIDAction)
    //    }
    //    var input:Input?
    
    private let service = MovieServie()
    private let keychain = KeychainSwift()
    // Input
//    private var callBackSessionIDAction: ((GuestSessionIDResult) -> Void)?
    // Output
//    var getGuestSessionIDAction: (() -> Void)!
    var setUpGuestSessionIDAction: (() -> Void)!
    
    var getRatedMoviesAction: ((_ guestSessionID: String) -> Void)!
    private var callBackRatedMoviesAction: ((_ movieResult: MovieResult) -> Void)?
    private var callBackSetUpGuestSessionID: ((_ guestSessionIDResult: GuestSessionIDResult) -> Void)?
    
    init() {
//        getGuestSessionIDAction = { [weak self] in
//            self?.getGuestSessionID()
//        }
        
        setUpGuestSessionIDAction = { [weak self] in
            self?.setUpGuestSessionID()
        }
        
        getRatedMoviesAction = { [weak self] (guestSessionID) in
            self?.getRatedMovies(guestSessionID: guestSessionID)
        }
    }
    
    public func setUpGuestSessionIDCompletionHandler(_ callBackSetUpGuestSessionID: @escaping (GuestSessionIDResult) -> Void) {
        self.callBackSetUpGuestSessionID = callBackSetUpGuestSessionID
    }
    
    public func getRatedMoviesCompletionHandler(_ callBackRatedMoviesAction: @escaping (_ movieResult: MovieResult) -> Void) {
        self.callBackRatedMoviesAction = callBackRatedMoviesAction
    }
    
//    private func getGuestSessionID() {
//        service.getGuestSessionID { [weak self] (result) in
//            switch result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let guestSessionIDResult):
//                //                self?.input?.completionHandler?(guestSessionIDResult)
//                self?.callBackSessionIDAction?(guestSessionIDResult)
//            }
//        }
//    }
    
    private func setUpGuestSessionID() {
        if keychain.get("session_id") == nil {
            service.getGuestSessionID { [weak self] (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let guestSessionIDResult):
                    self?.callBackSetUpGuestSessionID?(guestSessionIDResult)
                }
            }
        }
        print("CURRENT SESSION ID: \(String(describing: keychain.get("session_id")))")
    }
    
    private func getRatedMovies(guestSessionID: String) {
        service.getRatedMovies(guestSessionID: guestSessionID) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movieResult):
                self.callBackRatedMoviesAction?(movieResult)
            }
        }
    }
}
