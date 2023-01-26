//
//  HomeVC.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/23/23.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    var user = Auth.auth().currentUser
    let premiereDate = Calendar.current.date(byAdding: .second, value: 20, to: Date())
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
        label.text = "00:00:00"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUser()
        startTimer()
        
        view.backgroundColor = .systemBackground
    }
    
    
    
    func setUser() {
//        title = "Home"
    }
    
    func validateUser() {
        if user == nil {
            let authVC = AuthenticationVC()
            authVC.modalPresentationStyle = .fullScreen
            present(authVC, animated: false)
        }
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
        } else {
            tickerLabel.text = timeString(time: timeLeft ?? 1)
        }
        
//        if countDown <= 0 {
//            timer.invalidate()
//            tickerLabel.text = "Premeiring Now!"
//        } else {
//            countDown -= 1
//            tickerLabel.text = String(countDown)
//        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func setupViews() {
        [movieBannerImageView, tickerLabel].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            movieBannerImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            movieBannerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieBannerImageView.heightAnchor.constraint(equalToConstant: AssetSize.movieBannerHeight.rawValue),
            movieBannerImageView.widthAnchor.constraint(equalToConstant: AssetSize.movieBannerWidth.rawValue),
            
            tickerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tickerLabel.topAnchor.constraint(equalTo: movieBannerImageView.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            tickerLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            tickerLabel.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
        
    }
    
    
}

