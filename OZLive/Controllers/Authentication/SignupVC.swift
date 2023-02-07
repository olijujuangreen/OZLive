//
//  SignupVC.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/12/23.
//

import UIKit
import Firebase

class SignupVC: UIViewController {
    var completion: (() -> Void)?

//    MARK: - UIElements
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.placeholder = "Username"
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
    
    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder       = "Re-enter Password"
        textField.borderStyle       = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signup", for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func handleSignup() {
        guard let email = emailTextField.text?.lowercased(), let password = passwordTextField.text, let username = usernameTextField.text else { return }
        
        do {
            
            if !email.isValidEmail() { throw OZError.invalidEmail }
            if !password.isValidPassword() { throw OZError.weakPassword }
            if passwordTextField.text != confirmPasswordTextField.text { throw OZError.passwordsDoNotMatch }
            
        } catch let error as OZError {
            OZError.presentError(error, self)
            return
        } catch {
            print("An unexpected error occurred")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if error != nil { return }
            guard result != nil else { return }
            guard let uid = result?.user.uid else { return }
            
            let reference = Database.database().reference(fromURL: Storage.referenceURLString.rawValue)
            let usersReference = reference.child("users").child(uid)
            let values = ["email": email, "password": password, "username": username]
            usersReference.updateChildValues(values) { databaseError, databaseReference in
                if databaseError != nil {
                    print("THERE WAS AN ERROR \(databaseError)")
                    return
                }
                
                print("User Saved Successfully")
            }
            
            self.completion?()
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    
    
    
    
    
//    MARK: - Constraints
    func setupViews() {
        view.backgroundColor = .systemBackground
        [emailTextField, usernameTextField, passwordTextField, confirmPasswordTextField, signupButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.largeVerticalSpacing.rawValue * 2),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.widePadding.rawValue),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.widePadding.rawValue),
            
            usernameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.widePadding.rawValue),
            usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.widePadding.rawValue),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.widePadding.rawValue),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.widePadding.rawValue),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.widePadding.rawValue),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.widePadding.rawValue),
            
            signupButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            signupButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.widePadding.rawValue),
            signupButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.widePadding.rawValue)
        ])
    }
    
}
