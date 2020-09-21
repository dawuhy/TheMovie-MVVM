//
//  StarCell.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/21/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class StarCell: UICollectionViewCell {
    @IBOutlet weak var starImageView: UIImageView!
    
    func configure(indexPathDotRow: Int, currentVotePoint: Int) {
        if indexPathDotRow < currentVotePoint {
            self.starImageView.image = UIImage(systemName: "star.fill")
        }
        else {
            self.starImageView.image = UIImage(systemName: "star")
        }
    }
}
