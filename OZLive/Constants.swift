//
//  Constants.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/11/23.
//

import UIKit

enum OZColors {
    //    MARK: - Light Mode Sky
    case lightSky
    var color: UIColor {
        switch self {
        case .lightSky:
            return UIColor(red: 0/255, green: 255/255, blue: 242/255, alpha: 1.0)
        }
    }
}

enum OZGradients {
    case darkSky
    
    //    MARK: - Dark Mode Colors
    var darkGradientTop: CGColor {
        return UIColor(red: 253/255, green: 94/255, blue: 83/255, alpha: 1).cgColor
    }
    var darkGradientMiddle: CGColor {
        return UIColor(red: 0/255, green: 2/255, blue: 135/255, alpha: 1.0).cgColor
    }
    var darkGradientBottom: CGColor {
        return UIColor(red: 1/255, green: 0/255, blue: 68/255, alpha: 1.0).cgColor
    }
    
    var gradient: CAGradientLayer {
        switch self {
        case .darkSky:
            let gradient        = CAGradientLayer()
            gradient.colors     = [darkGradientTop, darkGradientMiddle, darkGradientBottom]
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint   = CGPoint(x: 0.5, y: 1)
            return gradient
        }
    }
}

enum LocalImages: String {
    // MARK: - Local Images
    case banner     = "OZLiveBanner"
    case loginBtn   = "LoginBtn"
    case signupBtn  = "SignupBtn"
}

//MARK: - Spacing
enum Constraints: CGFloat {
//    Horizontal Spacing
    case widePadding    = 8
    case narrowPadding  = 4
    
//    Vertical Spacing
    case largeVerticalSpacing       = 24
    case standardVerticalSpacing    = 16
}

//MARK: - Sizes
enum AssetSize: CGFloat {
    case largeBannerHeight      = 200
    case standarButtonWidth     = 120
    case standardButtonHeight   = 94
    case largeButtonWidth       = 180
    case largeButtonHeight      = 140
    case movieBannerHeight      = 400
    case movieBannerWidth       = 220
}

enum TextFieldValidation: String {
    case emailRegex     = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case passwordRegex  = "^(?=.*[0-9]).{8,}$"
}
