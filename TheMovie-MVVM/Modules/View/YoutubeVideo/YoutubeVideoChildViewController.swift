//
//  YoutubeVideoChildViewController.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/14/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit
import WebKit

class YoutubeVideoChildViewController: UIViewController {

    var movieID: Int!
    var keyVideo: String = ""
    var output: YoutubeVideoViewModel.Output?
    let viewModel = YoutubeVideoViewModel()
    @IBOutlet weak var videoWKWebView: WKWebView!
    
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: "YoutubeVideoChildViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        output?.loadDataAction?(movieID)
    }
    
    func bindViewModel() {
        let input = YoutubeVideoViewModel.Input { [weak self] movieTrailerResult in
            guard let self = self else {return}
            if movieTrailerResult.results.count > 0 {
                self.keyVideo = movieTrailerResult.results[0].key!
                self.loadVideo()
            }
            else {
                return
            }
        }
        
        self.output = viewModel.bindAction(input: input)
    }
    
    func loadVideo() {
        guard let videoURL = URL(string: "https://www.youtube.com/embed/\(keyVideo)") else {return}
        videoWKWebView.load(URLRequest(url: videoURL))
    }
}
