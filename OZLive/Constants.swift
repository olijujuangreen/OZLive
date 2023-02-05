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
    case movieBannerHeight      = 500
    case movieBannerWidth       = 275
}

//MARK: - Text Field Validation
enum TextFieldValidation: String {
    case emailRegex     = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case passwordRegex  = "^(?=.*[0-9]).{8,}$"
}

//MARK: - Storage
enum Storage: String {
    case referenceURLString = "https://ozlive-95340-default-rtdb.firebaseio.com/"
    case movieURLString     = "https://firebasestorage.googleapis.com/v0/b/ozlive-95340.appspot.com/o/Marvel%20Studios'%20Avengers_%20Endgame%20-%20Official%20Trailer.mp4?alt=media&token=02891b01-6f02-4164-b976-2930d2e3b1b9"
}
