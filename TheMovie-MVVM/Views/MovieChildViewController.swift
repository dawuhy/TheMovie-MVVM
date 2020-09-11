//
//  MovieChildViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/11/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class GroupMovieChildViewController: UIViewController {

    // Outlets
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    // ViewModels
    private let viewModel = MovieViewModel()
    private var output: MovieViewModel.Output?
    // Data
    private var arrayMovie = [Movie]() {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    private var movieType: MovieType!
    
    static func initGroupMovieChillView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        bindViewModel()
        output?.loadDataAction?(1, movieType)
    }
    
    private func bindViewModel() {
        let input = MovieViewModel.Input { [weak self] (result) in
            self?.arrayMovie = result.arrayMovie
        }
        self.output = viewModel.bindAction(input: input)
    }

    func setUpView() {
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        let nibMovieCell = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        movieCollectionView.register(nibMovieCell, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
}

extension GroupMovieChildViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        let movie = arrayMovie[indexPath.row]
        cell.configure(movie: movie)
        
        return cell
    }
}

extension GroupMovieChildViewController: UICollectionViewDelegate {
    
}

extension GroupMovieChildViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = movieCollectionView.bounds.height
        let width = height / 1.5
        
        return .init(width: width, height: height)
    }
}
