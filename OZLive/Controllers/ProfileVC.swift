//
//  ProfileVC.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/25/23.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    var completion: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        self.completion?()
    }

}
