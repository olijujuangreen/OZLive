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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUser()
        view.backgroundColor = .systemBackground
    }
    
    
    
    func setUser() {
        title = "Home"
    }
    
    func validateUser() {
        if user == nil {
            let authVC = AuthenticationVC()
            authVC.modalPresentationStyle = .fullScreen
            present(authVC, animated: false)
        }
    }


}

