//
//  MovieCollectionViewCell.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    static let identifier = "MovieCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(movie: Movie) {
        heartButton.isHidden = true
        self.titleLabel.text = movie.title
        posterImageView.loadImageFromPath(path: movie.posterPath)
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        titleLabel.text = ""
        heartButton.isHidden = true
    }
}
