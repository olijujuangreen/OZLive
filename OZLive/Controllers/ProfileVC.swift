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
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.circle.fill")
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 5
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.lightGray.cgColor
        return iv
    }()
    
    let profileImageSelectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Profile image change", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Personal user name here..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let stackView: UIStackView =  {
         let stackV = UIStackView()
         stackV.axis = .vertical
         stackV.spacing = 5
         stackV.translatesAutoresizingMaskIntoConstraints = false
         return stackV
     }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .systemBackground
        //setupNavigationBar()
        setupStackView()
    }
    
    @IBAction func profileImageSelectionButtonPressed(_ sender: UIButton) {
        presentPhotoActionSheet()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
            //Just a placeholder for testing buttons.
            print("Button Tapped")
        }
    
//    func setupNavigationBar() {
//        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
//        navigationItem.rightBarButtonItem = logoutButton
//    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        self.completion?()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(userNameTextField)
        
        userNameLabel.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor).isActive = true

        stackView.topAnchor.constraint(equalTo: profileImageSelectionButton.bottomAnchor, constant: 30).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    func setupViews() {
        
        view.addSubview(profileImageView)
        view.addSubview(profileImageSelectionButton)
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        profileImageSelectionButton.addTarget(self, action: #selector(profileImageSelectionButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: AssetSize.largeButtonWidth.rawValue),
            profileImageView.widthAnchor.constraint(equalToConstant: AssetSize.largeButtonWidth.rawValue),
            
            profileImageSelectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageSelectionButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: profileImageSelectionButton.bottomAnchor, constant: 160),
            logoutButton.heightAnchor.constraint(equalToConstant: 40),
            logoutButton.widthAnchor.constraint(equalToConstant: 100)
           
        ])
    }
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile picture", message: "How would you like to select a profile photo", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: {[weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Chose photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true //Allows crop box
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        profileImageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
