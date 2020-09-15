//
//  MovieDetailViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/14/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie!
    // Outlets
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var trailerChildView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var castChildView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpTrailerChildView(parentView: trailerChildView)
        setUpChildView(parentView: castChildView, movieID: movie.id)
    }
    
    func setUpView() {
        self.title = movie.title
        titleMovieLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        posterImageView.loadImageFromPath(path: movie.posterPath)
        overviewTextView.text = movie.overview
    }
    
    func setUpTrailerChildView(parentView: UIView) {
        let trailerViewController = YoutubeVideoChildViewController(movieID: movie.id)
        addChild(trailerViewController)
        parentView.addSubview(trailerViewController.view)
        trailerViewController.didMove(toParent: self)
        
        trailerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trailerViewController.view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0),
            trailerViewController.view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0),
            trailerViewController.view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            trailerViewController.view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0)
        ])
    }
    
    func setUpChildView(parentView: UIView, movieID: Int) {
        let childViewController = GroupCastViewController(movieID: movieID)
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
    
    deinit {
        print("MovieDetailViewController deinit")
    }
}

