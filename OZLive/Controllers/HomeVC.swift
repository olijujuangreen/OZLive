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
        validateUser()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func handleLogout() {
        // Logout code goes here
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // Present the AuthenticationVC modally
        let authVC = AuthenticationVC()
        authVC.modalPresentationStyle = .fullScreen
        present(authVC, animated: false, completion: nil)
    }
    
    func setUser() {
        title = user?.email
    }
    
    func validateUser() {
        if user == nil {
            let authVC = AuthenticationVC()
            authVC.modalPresentationStyle = .fullScreen
            present(authVC, animated: true)
        }
    }


}

