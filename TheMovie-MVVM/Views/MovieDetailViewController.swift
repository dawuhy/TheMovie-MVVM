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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpTrailerChildView(parentView: trailerChildView)
    }
    
    func setUpView() {
        titleMovieLabel.text = movie?.title
        releaseDateLabel.text = movie?.releaseDate
        setPosterImageView()
        overviewTextView.text = movie.overview
    }
    
    func setPosterImageView() {
        let queue = DispatchQueue(label: "queue")
        queue.async {
            do {
                let data = try Data(contentsOf: getURLImage(path: self.movie.posterPath!))
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                }
            } catch {
                print("Error load post image")
            }
        }
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
    
    deinit {
        print("MovieDetailViewController deinit")
    }
}

