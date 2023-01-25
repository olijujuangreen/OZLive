//
//  OZError.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/23/23.
//

import UIKit

enum OZError: Error {
    case invalidEmail
    case passwordsDoNotMatch
    case weakPassword
    
    
    
    static func presentError(_ error: OZError, _ viewController: UIViewController) {
        let message: String
        
        switch error {
        case .invalidEmail:
            message = "Invalid Email"
        case .passwordsDoNotMatch:
            message = "Passwords Do Not Match"
        case .weakPassword:
            message = "Password must be at least 8 characters long and contain at least 1 number"
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        viewController.present(alert, animated: true)
    }
    
    
}

