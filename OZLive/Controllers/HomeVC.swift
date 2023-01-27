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
        iv.backgroundColor = .systemRed
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let tickerLabel: UILabel = {
        let label = UILabel()
        label.text = "99:99:99"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 38)
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
            let vc = AuthenticationVC()
            present(vc, animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        startTimer()
        view.backgroundColor = .systemBackground
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
        [movieBannerImageView, tickerLabel, enterButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            movieBannerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.largeVerticalSpacing.rawValue),
            movieBannerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieBannerImageView.heightAnchor.constraint(equalToConstant: AssetSize.movieBannerHeight.rawValue),
            movieBannerImageView.widthAnchor.constraint(equalToConstant: AssetSize.movieBannerWidth.rawValue),
            
            tickerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tickerLabel.topAnchor.constraint(equalTo: movieBannerImageView.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            tickerLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            tickerLabel.heightAnchor.constraint(equalToConstant: 40),
            
            enterButton.topAnchor.constraint(equalTo: tickerLabel.bottomAnchor, constant: 8),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    
}

