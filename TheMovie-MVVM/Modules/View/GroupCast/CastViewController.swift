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
    
    //
    var arrayCast: [Cast] = [] {
        didSet {
            castCollectionView.reloadData()
        }
    }
    
    var viewModel = CastViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension GroupCastViewController {
    @IBAction func seeAllButtonTapped(_ sender: Any) {
        
    }
}

extension GroupCastViewController {
    func setUpView() {
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
    }
}

extension GroupCastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

extension GroupCastViewController: UICollectionViewDelegate {
    
}
