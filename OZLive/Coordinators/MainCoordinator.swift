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
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
         checkForUser()
    }
    
    func navigateHome() {
        let ozTabBar = OZTabBarController()
        window.makeKeyAndVisible()
        window.rootViewController = ozTabBar
    }
    
    func checkForUser() {
        if Auth.auth().currentUser != nil {
            navigateHome()
        } else {
            let navController = UINavigationController()
            window.rootViewController = navController
            let authCoordinator = AuthCoordinator(navigationController: navController)
            
            authCoordinator.completion = { [weak self] in
                self?.childCoordinators.removeAll {
                    $0 as? AuthCoordinator != nil
                }
                self?.navigateHome()
            }
            
            childCoordinators.append(authCoordinator)
            authCoordinator.start()
        }
    }
    
}
