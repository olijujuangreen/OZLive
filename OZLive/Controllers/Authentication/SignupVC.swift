//
//  SignupVC.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/12/23.
//

import UIKit
import FirebaseAuth

class SignupVC: UIViewController {
    var coordinator: MainCoordinator?
    
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
    
    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Re-enter Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("oodle Up", for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func handleSignup() {
        guard let email = emailTextField.text?.lowercased(), let password = passwordTextField.text else { return }
        
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
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil { return }
            guard result != nil else { return }
            self.coordinator!.navigateHome()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", TextFieldValidation.emailRegex.rawValue)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", TextFieldValidation.passwordRegex.rawValue)
        return passwordPred.evaluate(with: password)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        [emailTextField, passwordTextField, confirmPasswordTextField, signupButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.widePadding.rawValue),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.widePadding.rawValue),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
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
