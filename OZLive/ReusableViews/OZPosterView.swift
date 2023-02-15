//
//  OZPosterView.swift
//  OZLive
//
//  Created by Olijujuan Green on 2/14/23.
//

import UIKit

class OZPosterView : UIImageView {
    
    
    
    func addFadingBottom() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1]
        layer.insertSublayer(gradient, at: 0)
    }
    
    
}
 
