//
//  LoginVC.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/12/23.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    var completion: (() -> Void)?
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func loginPressed() {
        guard let email = emailTextField.text?.lowercased(), let password = passwordTextField.text else { return }
        
        do {
            
            if !email.isValidEmail() { throw OZError.invalidEmail }
            if !password.isValidPassword() { throw OZError.weakPassword }
            
        } catch let error as OZError {
            OZError.presentError(error, self)
            return
        } catch {
            print("An unexpected error occurred")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if error != nil { return }
            guard result != nil else { return }
            guard let self = self else { return }
            
            self.completion?()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        [emailTextField, passwordTextField, loginButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.widePadding.rawValue),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.widePadding.rawValue),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.widePadding.rawValue),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.widePadding.rawValue),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.standardVerticalSpacing.rawValue)
        ])
    }
    
}
