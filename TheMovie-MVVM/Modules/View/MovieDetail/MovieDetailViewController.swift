//
//  MovieDetailViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/14/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit
import KeychainSwift

class MovieDetailViewController: UIViewController {
    
    var movie: Movie!
    var sessionID: String!
    private var viewModel = MovieDetailViewModel()
    private var currentUserRating = 0
    var ratedMovieList: [Movie] = [] {
        didSet {
            User.listRatedMovie = ratedMovieList
            if ratedMovieList.filter({$0.id == movie.id}).count > 0  {
                currentUserRating = ratedMovieList.filter {$0.id == movie.id}[0].ratingOfUser!
                ratingOfUserLabel.text = "\(currentUserRating)"
                ratingOfUserLabel.font = .boldSystemFont(ofSize: 20)
                yourRatingLabel.isHidden = false
                starImageView.image = UIImage(systemName: "star.fill")
            } else {
                yourRatingLabel.isHidden = true
                self.currentUserRating = 0
                starImageView.image = UIImage(systemName: "star")
                ratingOfUserLabel.text = "Rate this"
                ratingOfUserLabel.font = .boldSystemFont(ofSize: 14)
            }
        }
    }
    let keychain = KeychainSwift()
    
    // Outlets
    @IBOutlet weak var castChildView: UIView!
    @IBOutlet weak var similarMoviesChildView: UIView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var trailerChildView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var ratingOfMovieLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var yourRatingLabel: UILabel!
    @IBOutlet weak var ratingOfUserLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindViewModel()
        self.setUpView()
        self.setUpTrailerChildView(parentView: self.trailerChildView)
        self.setUpCastChildView(parentView: self.castChildView, movieID: self.movie.id)
        self.setUpSimilarMoviesChildView(parentView: similarMoviesChildView, rootMovieID: movie.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        self.showSpinner(onView: self.view)
        setUpUserRatingLabel()
        self.viewModel.getRatedMoviesAction(self.keychain.get("session_id")!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.removeSpinner()
        }
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
    }
    
    func setUpRatingLabel() {
        let string = "\(movie.voteAverage)/10"
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
    
    func setUpCastChildView(parentView: UIView, movieID: Int) {
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
    
    func setUpSimilarMoviesChildView(parentView: UIView, rootMovieID: Int) {
        let childViewController = GroupMovieChildViewController.initGroupSimilarMovieChillView(rootMovieID: rootMovieID)
        addChild(childViewController)
        parentView.addSubview(childViewController.view)
        parentView.backgroundColor = .red
        childViewController.didMove(toParent: self)
        
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childViewController.view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0),
            childViewController.view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0),
            childViewController.view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            childViewController.view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0)
        ])
    }
    
    func bindViewModel() {
        viewModel.getRatedMoviesCompletionHandler { [weak self] (movieResult) in
            guard let self = self else {return}
            self.ratedMovieList = movieResult.arrayMovie
            print(self.ratedMovieList.count)
        }
    }
    
    func setUpUserRatingLabel() {
        if User.listRatedMovie.filter({$0.id == movie.id}).count > 0  {
            currentUserRating = User.listRatedMovie.filter {$0.id == movie.id}[0].ratingOfUser!
            ratingOfUserLabel.text = "\(currentUserRating)"
            ratingOfUserLabel.font = .boldSystemFont(ofSize: 20)
            yourRatingLabel.isHidden = false
            starImageView.image = UIImage(systemName: "star.fill")
        } else {
            yourRatingLabel.isHidden = true
            self.currentUserRating = 0
            starImageView.image = UIImage(systemName: "star")
            ratingOfUserLabel.text = "Rate this"
            ratingOfUserLabel.font = .boldSystemFont(ofSize: 14)
        }
    }
}

extension MovieDetailViewController {
    @IBAction func rateMovieTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RatingStoryboard", bundle: nil)
        let ratingMovieViewController = storyboard.instantiateViewController(withIdentifier: "RatingMovieViewController") as! RatingMovieViewController
        
        ratingMovieViewController.movie = self.movie
        ratingMovieViewController.currentVotePoint = currentUserRating
        
        ratingMovieViewController.modalPresentationStyle = .fullScreen
        present(ratingMovieViewController, animated: true)
    }
}
