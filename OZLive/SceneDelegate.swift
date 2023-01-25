//
//  SceneDelegate.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/11/23.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let navController = UINavigationController(rootViewController: createTabBarController())
        window?.rootViewController = navController
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }
    
    func createTabBarController() -> UITabBarController{
        let tabBar              = UITabBarController()
        tabBar.viewControllers  = [createHomeNavController(), createProfileNavController()]
        return tabBar
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


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

