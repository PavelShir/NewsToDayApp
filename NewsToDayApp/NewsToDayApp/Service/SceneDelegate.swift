//
//  SceneDelegate.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let navigationController: UINavigationController

          if isOnboardingCompleted() {
              let tabBarController = TabBarViewController()
              navigationController = UINavigationController(rootViewController: tabBarController)
          } else {
              let onboardingController = OnboardingViewController()
              navigationController = UINavigationController(rootViewController: onboardingController)
          }

          window.rootViewController = navigationController
          navigationController.navigationBar.isHidden = true
          window.makeKeyAndVisible()
        
        
        //        if AuthManager.shared.isUserLoggedIn() {
        //            window.rootViewController = OnboardingViewController()
        //        } else {
        //            window.rootViewController = LoginViewController()
        //        }
        
        
        
//        let rootViewController = TabBarViewController()
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        
//        window.rootViewController = navigationController
//        
//        window.makeKeyAndVisible()
        
       
    }
    
    
    private func isOnboardingCompleted() -> Bool {
      return UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}

