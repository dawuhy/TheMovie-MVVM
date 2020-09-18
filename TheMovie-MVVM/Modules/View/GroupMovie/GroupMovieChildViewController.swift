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
    private var output: GroupMovieViewModel.Output?
    // Data
    private var arrayMovie = [Movie]() {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    private var movieType: MovieType!
    private let keychain = KeychainSwift()
    
    static func initGroupMovieChillView(movieType: MovieType) -> GroupMovieChildViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let groupMovieChildViewController = storyboard.instantiateViewController(identifier: "GroupMovieChildViewController") as! GroupMovieChildViewController
        groupMovieChildViewController.movieType = movieType
        return groupMovieChildViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        bindViewModel()
        output?.getMovie?(1, movieType)
        
    }
    
    private func bindViewModel() {
        let input = GroupMovieViewModel.Input { [weak self] (movieResult) in
            self?.arrayMovie.append(contentsOf: movieResult.arrayMovie)
        }
        self.output = viewModel.bindAction(input: input)
    }

    func setUpView() {
        titleHeaderLabel.text = movieType.title()
        // Collection view
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        let nibMovieCell = UINib(nibName: MovieCell.identifier, bundle: nil)
        movieCollectionView.register(nibMovieCell, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    @IBAction func didTapSeeAllButton(_ sender: Any) {
        let listMovieViewController = SeeAllMovieViewController()
        listMovieViewController.movieType = movieType
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
