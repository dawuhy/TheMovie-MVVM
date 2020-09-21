//
//  HomePageViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/11/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit
import KeychainSwift

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var topRatedMovieChildView: UIView!
    @IBOutlet weak var popularMovieChildView: UIView!
    @IBOutlet weak var nowPlayingMovieChildView: UIView!
    
    private let viewModel = HomePageViewModel()
    private var output: HomePageViewModel.Output?
    private let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        setUpChildView(parentView: topRatedMovieChildView, movieType: .top_rated)
        setUpChildView(parentView: popularMovieChildView, movieType: .popular)
        setUpChildView(parentView: nowPlayingMovieChildView, movieType: .now_playing)
    }
    
    func setUpChildView(parentView: UIView, movieType: MovieType) {
        let childViewController = GroupMovieChildViewController.initGroupMovieChillView(movieType: movieType)
        addChild(childViewController)
        parentView.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
        
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childViewController.view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0),
            childViewController.view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0),
            childViewController.view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            childViewController.view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0)
        ])
    }
    
    private func bindViewModel() {
        let input = HomePageViewModel.Input { guestSessionIDResult in
            self.keychain.set(guestSessionIDResult.guestSessionID, forKey: "session_id")
        }
        
        self.output = viewModel.bindAction(input: input)
    }
}
