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
        output?.loadDataAction?(page, movieType)
    }

    func setUpView() {
        self.title = movieType.title()
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self

        let nibMovieCell = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        movieCollectionView.register(nibMovieCell, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }

    func bindViewModel() {
        let input = GroupMovieViewModel.Input { [weak self] (result) in
            self?.arrayMovie = result.arrayMovie
        }
        self.output = viewModel.bindAction(input: input)
    }
}

extension SeeAllMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayMovie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell

        let movie = arrayMovie[indexPath.row]
        cell.configure(movie: movie)

        return cell
    }
}

extension SeeAllMovieViewController: UICollectionViewDelegate {

}

extension SeeAllMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = movieCollectionView.bounds.width / 2 - 4
        let height = width * 1.5

        return .init(width: width, height: height)
    }
}
