//
//  LaunchScreenViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 15.11.2024.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.14, green: 0.21, blue: 0.66, alpha: 1)
        
        let logoImageView = UIImageView(image: UIImage(named: "News ToDay"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.switchToMainScreen()
        }
    }
    
    private func switchToMainScreen() {
            guard let window = UIApplication.shared.windows.first else { return }
            
            let mainViewController = OnboardingViewController()
            let navigationController = UINavigationController(rootViewController: mainViewController)
            
            window.rootViewController = navigationController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        }
}

