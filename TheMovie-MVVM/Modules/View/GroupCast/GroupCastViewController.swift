//
//  CastChildViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/15/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class GroupCastViewController: UIViewController{
    
    // Outlet
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    // Data
    var viewModel = GroupCastViewModel()
    var arrayCast = [Cast]() {
        didSet {
            castCollectionView.reloadData()
        }
    }
    var movieID: Int!
    var output: GroupCastViewModel.Output?
    
    init(movieID: Int ) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        bindViewModel()
        output?.getCastsOf?(movieID)
    }
}

extension GroupCastViewController {
    @IBAction func seeAllButtonTapped(_ sender: Any) {
        
    }
}

extension GroupCastViewController {
    func setUpView() {
        let nibCastCell = UINib(nibName: CastCollectionViewCell.identifier, bundle: nil)
        self.castCollectionView.register(nibCastCell, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        
        titleHeaderLabel.text = "Cast"
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
    }
    
    func bindViewModel() {
        let input = GroupCastViewModel.Input { [weak self] (castResult) in
            self?.arrayCast = castResult.cast
        }
        self.output = viewModel.bindAction(input: input)
    }
}

extension GroupCastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as! CastCollectionViewCell
        
        let cast = arrayCast[indexPath.row]
        cell.configure(withCast: cast)
        
        return cell
    }
}

extension GroupCastViewController: UICollectionViewDelegate {
    
}

extension GroupCastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = castCollectionView.bounds.height
        let width = height / 1.5
        
        return .init(width: width, height: height)
    }
}
