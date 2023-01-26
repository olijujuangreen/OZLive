//
//  OZTabBarController.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/26/23.
//
import UIKit

class OZTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [createHomeNavController(), createProfileNavController()]
    }
    
    func createHomeNavController() -> UINavigationController {
        let homeVC         = HomeVC()
        homeVC.title       = "Home"
        homeVC.tabBarItem  = UITabBarItem(title: "Home", image: UIImage.init(systemName: "house"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createProfileNavController() -> UINavigationController {
        let profileVC         = ProfileVC()
        profileVC.title       = "Profile"
        profileVC.tabBarItem  = UITabBarItem(title: "Profile", image: UIImage.init(systemName: "person"), tag: 1)
        
        return UINavigationController(rootViewController: profileVC)
    }
    
}
