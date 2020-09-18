//
//  CastCollectionViewCell.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/15/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    static let identifier = "CastCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        posterImageView.image = nil
        castNameLabel.text = ""
        characterNameLabel.text = ""
    }
    
    public func configure(withCast cast: Cast) {
        castNameLabel.text = cast.name
        characterNameLabel.text = cast.character
        posterImageView.loadImageFromPath(path: cast.profilePath)
    }
}
