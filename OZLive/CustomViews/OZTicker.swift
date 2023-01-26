//
//  OZTicker.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/26/23.
//

import UIKit

class OZTicker {
    var premiereTime: Date
    var timer: Timer?
    var tickerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(premiereTime: Date) {
        self.premiereTime = premiereTime
    }

    func startTicker() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTicker), userInfo: nil, repeats: true)
    }

    @objc func updateTicker() {
        let timeUntilPremiere = premiereTime.timeIntervalSinceNow
        if timeUntilPremiere > 0 {
            let hours = Int(timeUntilPremiere / 3600)
            let minutes = Int((timeUntilPremiere.truncatingRemainder(dividingBy: 3600)) / 60)
            let seconds = Int(timeUntilPremiere.truncatingRemainder(dividingBy: 60))
            let tickerString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            tickerLabel.text = tickerString
        } else {
            timer?.invalidate()
            tickerLabel.text = "Premiere is now!"
        }
    }
    
//    func addTickerToView(view: UIView) {
//        view.addSubview(tickerLabel)
//        NSLayoutConstraint.activate([
//            tickerLabel.bottomAnchor.constraint(equalTo: movieBannerImageView.bottomAnchor, constant: 10),
//            tickerLabel.centerXAnchor.constraint(equalTo: movieBannerImageView.centerXAnchor),
//        ])
//    }
}




