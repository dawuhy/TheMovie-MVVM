//
//  MovieCollectionViewCell.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/10/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    static let identifier = "MovieCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(movie: Movie) {
        heartButton.isHidden = true
        self.titleLabel.text = movie.title
        var posterStringURL: String!
        let queue = DispatchQueue(label: "queue")
        queue.async {
            if movie.posterPath == nil {
                posterStringURL = "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png"
            } else {
                posterStringURL = "https://image.tmdb.org/t/p/w500/\(movie.posterPath!)"
            }
            do {
                let data = try Data(contentsOf: URL(string: posterStringURL)!)
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
}
