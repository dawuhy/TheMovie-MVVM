//
//  SeeAllMovieViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/11/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class SeeAllMovieViewController: UIViewController {
    // Outlets
    @IBOutlet weak var movieCollectionView: UICollectionView!

    var arrayMovie: [Movie] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    var viewModel = GroupMovieViewModel()
    private var output: GroupMovieViewModel.Output?
    var movieType: MovieType!
    private var page: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        bindViewModel()
        output?.getMovie?(page, movieType)
    }

    func setUpView() {
        self.title = movieType.title()
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self

        let nibMovieCell = UINib(nibName: MovieCell.identifier, bundle: nil)
        movieCollectionView.register(nibMovieCell, forCellWithReuseIdentifier: MovieCell.identifier)
    }

    func bindViewModel() {
        let input = GroupMovieViewModel.Input { [weak self] (movieResult) in
            self?.arrayMovie.append(contentsOf: movieResult.arrayMovie)
        }
        self.output = viewModel.bindAction(input: input)
    }
}

extension SeeAllMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayMovie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell

        let movie = arrayMovie[indexPath.row]
        cell.configure(movie: movie)

        return cell
    }
}

extension SeeAllMovieViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if movieCollectionView.contentOffset.y >= (movieCollectionView.contentSize.height - movieCollectionView.frame.size.height) {
            // MARK: Load more movie
            page += 1
            output?.getMovie?(page, movieType)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MovieDetailStoryboard", bundle: nil)
        let movieDetailViewController = storyboard.instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        
        let movie = arrayMovie[indexPath.row]
        movieDetailViewController.movie = movie
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

extension SeeAllMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = movieCollectionView.bounds.width / 2 - 4
        let height = width * 1.5

        return .init(width: width, height: height)
    }
}
