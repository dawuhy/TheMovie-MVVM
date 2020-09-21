//
//  RatingMovieViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/18/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit
import KeychainSwift

class RatingMovieViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterMovieImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var starCollectionView: UICollectionView!
    
    private var currentVotePoint: Int = 0
    internal var movie: Movie!
    private let keychain = KeychainSwift()
    private var sessionID: String!
    private var output: RatingMovieViewModel.Output?
    let viewModel = RatingMovieViewModel()
    private var statusMessage: String? {
        didSet {
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        bindViewModel()
    }
    
    func setUpView() {
        self.sessionID = keychain.get("session_id")
        starCollectionView.delegate = self
        starCollectionView.dataSource = self
        starCollectionView.backgroundColor = nil
        
        var image: UIImage?
        do {
            let data = try Data(contentsOf: getUrlImage(path: movie.posterPath))
            image = UIImage(data: data)
        } catch {
            print("Error image")
        }
        self.posterMovieImageView.image = image
        self.questionLabel.text = "How would you rate \"\(movie.title)\"?"
        backgroundImageView.image = image
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.addSubview(blurEffectView)
        
    }
    
    func bindViewModel() {
        let input = RatingMovieViewModel.Input { [weak self] (ratingMovieResponse) in
            self?.statusMessage = ratingMovieResponse.status_message
            print(self?.statusMessage)
        }
        self.output = viewModel.bindAction(input: input)
    }
    
    @IBAction func sendRatingButtonTapped(_ sender: Any) {
        if self.currentVotePoint > 0 {
            output?.ratingMovie?(keychain.get("session_id")!, movie.id, Double(self.currentVotePoint))
        }
    }
    
    deinit {
        print("RatingMovieViewController deinit.")
    }
}

extension RatingMovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentVotePoint = indexPath.row + 1
        starCollectionView.reloadData()
    }
}

extension RatingMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = starCollectionView.dequeueReusableCell(withReuseIdentifier: "StarCell", for: indexPath) as! StarCell
        
        cell.configure(indexPathDotRow: indexPath.row, currentVotePoint: self.currentVotePoint)
        
        return cell
    }
}

extension RatingMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = starCollectionView.bounds.width / 10 - 5
        let height = width
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
