//
//  AuthenticationVC.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/11/23.
//

import UIKit




class AuthenticationVC: UIViewController {
    
    let bannerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: LocalImages.banner.rawValue)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let bgImageView: UIImageView = {
        let image = UIImage(named: "OZLiveAuthBg")
        let iv = UIImageView(image: image)
        iv.image = image
        iv.backgroundColor = .systemRed
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let loginButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: LocalImages.loginBtn.rawValue)
        btn.setImage(img, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    let signupButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: LocalImages.signupBtn.rawValue)
        btn.setImage(img, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupViews()
    }
    
    func setupViews() {
        [bgImageView, loginButton, signupButton].forEach { view.addSubview($0) }
        
        
        NSLayoutConstraint.activate([
            
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
//            bannerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            bannerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.largeVerticalSpacing.rawValue * 2),
//            bannerImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Constraints.widePadding.rawValue),
//            bannerImageView.heightAnchor.constraint(equalToConstant: AssetSize.largeBannerHeight.rawValue),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constraints.largeVerticalSpacing.rawValue * 2),
            loginButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -Constraints.narrowPadding.rawValue),
            loginButton.widthAnchor.constraint(equalToConstant: AssetSize.largeButtonWidth.rawValue),
            loginButton.heightAnchor.constraint(equalToConstant: AssetSize.largeButtonHeight.rawValue),
            
            signupButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constraints.largeVerticalSpacing.rawValue * 2),
            signupButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: Constraints.narrowPadding.rawValue),
            signupButton.widthAnchor.constraint(equalToConstant: AssetSize.largeButtonWidth.rawValue),
            signupButton.heightAnchor.constraint(equalToConstant: AssetSize.largeButtonHeight.rawValue),
        ])
    }
    
    func setupButtons() {
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupPressed), for: .touchUpInside)
    }
    
    @objc func loginPressed() {
        let vc = LoginVC()
        present(vc, animated: true)
    }
    
    @objc func signupPressed() {
        let signupVC = SignupVC()
        signupVC.modalPresentationStyle = .formSheet
        present(signupVC, animated: true)
    }

}
