//
//  MoviePlayerVC.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/26/23.
//

import UIKit
import AVFoundation

class MoviePlayerVC: UIViewController {
    var player = AVPlayer()
    
    let moviePlayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dismissButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(systemName: "x.circle.fill")
        btn.tintColor = .white
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    @objc func dismissButtonPressed() {
        player.pause()
        self.dismiss(animated: true)
    }
    
    let chatTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemRed
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    
    
    
    
    
    
    func setupViews() {
        let moviePlayerHeight = (view.frame.width * 1080) / 1920
        [moviePlayerView, chatTableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
        
            moviePlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            moviePlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviePlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviePlayerView.heightAnchor.constraint(equalToConstant: moviePlayerHeight),
            
            chatTableView.topAnchor.constraint(equalTo: moviePlayerView.bottomAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.largeVerticalSpacing.rawValue)
        
        ])
        
        self.view.layoutIfNeeded()
        setupPlayer()
        moviePlayerView.addSubview(dismissButton)
        dismissButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    func setupPlayer() {
        let movieURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/ozlive-95340.appspot.com/o/Marvel%20Studios'%20Avengers_%20Endgame%20-%20Official%20Trailer.mp4?alt=media&token=02891b01-6f02-4164-b976-2930d2e3b1b9")!
        
        player = AVPlayer(url: movieURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = moviePlayerView.bounds
        moviePlayerView.layer.addSublayer(playerLayer)
        
        player.play()
        
        let time = CMTime(seconds: 30, preferredTimescale: 1)
        let tolerance = CMTime(seconds: 5, preferredTimescale: 1)
        player.seek(to: time, toleranceBefore: tolerance, toleranceAfter: tolerance)

    }

}
