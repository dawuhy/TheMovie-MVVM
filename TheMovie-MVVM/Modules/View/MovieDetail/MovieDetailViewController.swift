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
    var sessionID: String!
    // Outlets
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var trailerChildView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var castChildView: UIView!
    @IBOutlet weak var ratingOfMovieLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var yourRatingLabel: UILabel!
    @IBOutlet weak var ratingOfUserLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpTrailerChildView(parentView: trailerChildView)
        setUpChildView(parentView: castChildView, movieID: movie.id)
    }
    
    deinit {
        print("MovieDetailViewController deinit")
    }
}

extension MovieDetailViewController {
    func setUpView() {
        self.title = movie.title
        titleMovieLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        posterImageView.loadImageFromPath(path: movie.posterPath)
        overviewTextView.text = movie.overview
        setUpRatingLabel()
        if movie.voteCount > 1 {
            voteCountLabel.text = "\(movie.voteCount) votes"
        } else {
            voteCountLabel.text = "\(movie.voteCount) vote"
        }
        yourRatingLabel.isHidden = true
    }
    
    func setUpRatingLabel() {
        let string = "\(movie.rating)/10"
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttributes([
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ], range: NSRange(location: 0, length: 3))
        ratingOfMovieLabel.attributedText = attributedString
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
}

extension MovieDetailViewController {
    @IBAction func rateMovieTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RatingStoryboard", bundle: nil)
        let ratingMovieViewController = storyboard.instantiateViewController(withIdentifier: "RatingMovieViewController") as! RatingMovieViewController
        
        ratingMovieViewController.movie = self.movie
        
        present(ratingMovieViewController, animated: true)
    }
}
