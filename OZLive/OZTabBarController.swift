//
//  OZTabBarController.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/26/23.
//
import UIKit

protocol OZTabBarControllerDelegate: AnyObject {
    func returnToAuth()
}

class OZTabBarController: UITabBarController {
    weak var tabBarDelegate: OZTabBarControllerDelegate?
    
    init(tabBarDelegate: OZTabBarControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarDelegate = tabBarDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [createHomeNavController(), createProfileNavController(), createSettingsNavController()]
    }
    
    func createHomeNavController() -> UINavigationController {
        let homeVC         = HomeVC()
        homeVC.tabBarItem  = UITabBarItem(title: "Home", image: UIImage.init(systemName: "house"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createProfileNavController() -> UINavigationController {
        let profileVC         = ProfileVC()
        profileVC.completion  = { self.tabBarDelegate?.returnToAuth() }
        profileVC.title       = "Profile"
        profileVC.tabBarItem  = UITabBarItem(title: "Profile", image: UIImage.init(systemName: "person"), tag: 1)
        
        return UINavigationController(rootViewController: profileVC)
    }
    
    func createSettingsNavController() -> UINavigationController {
        let settingsVC         = SettingsVC()
        settingsVC.title       = "Settings"
        settingsVC.tabBarItem  = UITabBarItem(title: "Settings", image: UIImage.init(systemName: "slider.horizontal.3"), tag: 2)
        
        return UINavigationController(rootViewController: settingsVC)
    }
    
}
