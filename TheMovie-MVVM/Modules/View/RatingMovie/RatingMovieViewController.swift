//
//  RatingMovieViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/18/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit

class RatingMovieViewController: UIViewController {
    @IBOutlet weak var posterMovieImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    var movie: Movie!
    @IBOutlet weak var _1StarButton: UIButton!
    @IBOutlet weak var _2StarButton: UIButton!
    @IBOutlet weak var _3StarButton: UIButton!
    @IBOutlet weak var _4StarButton: UIButton!
    @IBOutlet weak var _5StarButton: UIButton!
    @IBOutlet weak var _6StarButton: UIButton!
    @IBOutlet weak var _7StarButton: UIButton!
    @IBOutlet weak var _8StarButton: UIButton!
    @IBOutlet weak var _9StarButton: UIButton!
    @IBOutlet weak var _10StarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView() {
        self.posterMovieImageView.loadImageFromPath(path: movie.posterPath)
        self.questionLabel.text = "How would you rate \"\(movie.title)\"?"
//        view.backgroundColor = UIColor(patternImage: posterMovieImageView.image!)
//        view.backgroundColor = .black
    }
    
    @IBAction func _1StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @IBAction func _2StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @IBAction func _3StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @IBAction func _4StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @IBAction func _5StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @IBAction func _6StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @IBAction func _7StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @IBAction func _8StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @IBAction func _9StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @IBAction func _10StarButtonTapped(_ sender: Any) {
        _1StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _2StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _3StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _4StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _5StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _6StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _7StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _8StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _9StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        _10StarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    @IBAction func sendRatingButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    deinit {
        print("RatingMovieViewController deinit.")
    }
}
