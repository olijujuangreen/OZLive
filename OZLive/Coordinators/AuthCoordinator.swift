//
//  AuthCoordinator.swift
//  OZLive
//
//  Created by Olijujuan Green on 2/6/23.
//

import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start()  {
        
    }
    
    
}
