//
//  HomeVC.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/23/23.
//

import UIKit
import Firebase

class HomeVC: UIViewController{
    
    var user = Auth.auth().currentUser
    let premiereDate = Calendar.current.date(byAdding: .second, value: 5, to: Date())
    var countDown = 20
    var timer = Timer()
    
    let movieBannerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Avengers")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let movieDetailView: MovieDetailView = {
        let view = MovieDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tickerLabel: UILabel = {
        let label = UILabel()
        label.text = "99:99:99"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enter", for: .normal)
        button.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func enterButtonPressed() {
        
        if user != nil {
            let vc = MoviePlayerVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
//            let vc = AuthenticationVC()
//            present(vc, animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        startTimer()
    }
    
    
    
    
    
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        
        let currentDate = Date()
        let timeLeft = premiereDate?.timeIntervalSince(currentDate)
        
        if timeLeft ?? 1 <= 0 {
            timer.invalidate()
            tickerLabel.text = "Premiering Now!"
            enterButton.isHidden = false
        } else {
            tickerLabel.text = timeString(time: timeLeft ?? 1)
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        [movieBannerImageView, movieDetailView, tickerLabel, enterButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            movieBannerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            movieBannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieBannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieBannerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            movieDetailView.topAnchor.constraint(equalTo: movieBannerImageView.bottomAnchor),
            movieDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailView.heightAnchor.constraint(equalToConstant: 320),
            
            tickerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tickerLabel.topAnchor.constraint(equalTo: movieDetailView.bottomAnchor, constant: Constraints.largeVerticalSpacing.rawValue),
            tickerLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            tickerLabel.heightAnchor.constraint(equalToConstant: Constraints.movieTitleLabelHeight.rawValue + 2),

            enterButton.topAnchor.constraint(equalTo: tickerLabel.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
}

