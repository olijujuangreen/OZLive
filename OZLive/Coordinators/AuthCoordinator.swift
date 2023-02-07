//
//  AuthCoordinator.swift
//  OZLive
//
//  Created by Olijujuan Green on 2/6/23.
//

import UIKit

protocol AuthDelegate: AnyObject {
    func didTapLogin()
    func didTapSignup()
}

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var completion: (()-> Void)?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start()  {
        let authVC = AuthenticationVC(authDelegate: self)
        navigationController.pushViewController(authVC, animated: true)
    }
    
    
}

extension AuthCoordinator: AuthDelegate {
    func didTapLogin() {
        let loginVC = LoginVC()
        loginVC.completion = completion
        loginVC.modalPresentationStyle = .formSheet
        navigationController.present(loginVC, animated: true)
    }
    
    func didTapSignup() {
        let signupVC = SignupVC()
        signupVC.completion = completion
        signupVC.modalPresentationStyle = .formSheet
        navigationController.present(signupVC, animated: true)
    }
    
}
