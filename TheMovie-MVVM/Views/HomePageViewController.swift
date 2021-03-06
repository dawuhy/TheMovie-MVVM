//
//  ViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var collectionViewMovie: UICollectionView!
    private let viewModel = HomePageViewModel()
    private var data = [Movie]() {
        didSet {
            collectionViewMovie.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
//        viewModel.loadDataAction?()
        viewModel.getMovie(page: 1, type: .popular)
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.registerActions {[weak self] (movieResult) in
            self?.data = movieResult.arrayMovie
        }
    }
    
    func setUpView() {
        collectionViewMovie.dataSource = self
        collectionViewMovie.delegate = self
        
        let movieCellNib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        collectionViewMovie.register(movieCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        let movie = data[indexPath.row]
        cell.configure(movie: movie)
        
        return cell
    }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionViewMovie.frame.width / 2
        let height = width * 1.5
        return .init(width: width, height: height)
    }
}
