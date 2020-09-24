//
//  GroupMovieChildViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/11/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit
import KeychainSwift

class GroupMovieChildViewController: UIViewController {

    // Outlets
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    // ViewModels
    private let viewModel = GroupMovieViewModel()
    // Data
    private var arrayMovie = [Movie]() {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    private var movieType: MovieType?
    private var rootMovieID: Int?
    private let keychain = KeychainSwift()
    
    static func initGroupMovieChillView(movieType: MovieType) -> GroupMovieChildViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let groupMovieChildViewController = storyboard.instantiateViewController(identifier: "GroupMovieChildViewController") as! GroupMovieChildViewController
        groupMovieChildViewController.movieType = movieType
        return groupMovieChildViewController
    }
    
    static func initGroupSimilarMovieChillView(rootMovieID: Int) -> GroupMovieChildViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let groupMovieChildViewController = storyboard.instantiateViewController(identifier: "GroupMovieChildViewController") as! GroupMovieChildViewController
        groupMovieChildViewController.rootMovieID  = rootMovieID
        return groupMovieChildViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        if let movieType = movieType {
            viewModel.getMovieFromTypeAction(1, movieType)
        } else if let rootMovieID = rootMovieID {
            viewModel.getSimilarMovieAction(rootMovieID, 1)
        }
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.getMovieCompletionHandler { [weak self] (movieResult) in
            guard let self = self else {return}
            self.arrayMovie.append(contentsOf: movieResult.arrayMovie)
        }
        
        viewModel.getSimilarMovieCompletionHandler { [weak self] (movieResult) in
            guard let self = self else {return}
            self.arrayMovie.append(contentsOf: movieResult.arrayMovie)
        }
    }

    func setUpView() {
        if let movieType = movieType {
            titleHeaderLabel.text = movieType.title()
        } else if rootMovieID != nil {
            titleHeaderLabel.text = "Similar Movies"
        }
        
        // Collection view
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        let nibMovieCell = UINib(nibName: MovieCell.identifier, bundle: nil)
        movieCollectionView.register(nibMovieCell, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    @IBAction func didTapSeeAllButton(_ sender: Any) {
        let listMovieViewController = SeeAllMovieViewController()
        if let movieType = movieType {
            listMovieViewController.movieType = movieType
        } else if rootMovieID != nil {
            listMovieViewController.rootMovieID = rootMovieID
        }
        parent?.navigationController?.pushViewController(listMovieViewController, animated: true)
    }
}

extension GroupMovieChildViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        let movie = arrayMovie[indexPath.row]
        cell.configure(movie: movie)
        
        return cell
    }
}

extension GroupMovieChildViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MovieDetailStoryboard", bundle: nil)
        let movieDetailViewController = storyboard.instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        
        let movie = arrayMovie[indexPath.row]
        movieDetailViewController.movie = movie
        
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

extension GroupMovieChildViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = movieCollectionView.bounds.height
        let width = height / 1.5
        
        return .init(width: width, height: height)
    }
}
