//
//  MainCoordinator.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/23/23.
//

import UIKit
import Firebase

class MainCoordinator: Coordinator {
    var childCoordinators   = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
         checkForUser()
    }
    
    func navigateHome() {
        let homeVC = HomeVC()
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func navigateToSignup() {
        let signupVC = SignupVC()
        navigationController.pushViewController(signupVC, animated: true)
    }
    
    func checkForUser() {
        if Auth.auth().currentUser != nil {
            let homeVC = HomeVC()
//            homeVC.coordinator = self
            navigationController.pushViewController(homeVC, animated: true)
        } else {
            let authVC = AuthenticationVC()
            navigationController.pushViewController(authVC, animated: true)
        }
    }
    
}
