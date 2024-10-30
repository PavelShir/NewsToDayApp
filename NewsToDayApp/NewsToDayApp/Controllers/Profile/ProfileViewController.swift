//
//  ProfileViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let navigationBar = CustomNavigationBar()
    private var user: UserModel?
    
    private let fotoImage: UIImageView = {
        let fotoImage = UIImageView()
        fotoImage.contentMode = .scaleAspectFill
        fotoImage.image = UIImage(named: "userImage")
        fotoImage.tintColor = .gray
        fotoImage.isUserInteractionEnabled = true
       
        return fotoImage
    }()
    
    private let userName: UILabel = {
        let userName = UILabel()
        userName.text = "Dev P"
        userName.font = .systemFont(ofSize: 16, weight: .semibold)
        userName.textColor = .black
        userName.layer.cornerRadius = 12
        
        return userName
    }()
    
    private let userEmail: UILabel = {
       let userEmail = UILabel()
        userEmail.font = .systemFont(ofSize: 14, weight: .regular)
        userEmail.text = "dev@gmail.com"
        userEmail.textColor = .darkGray
        
        return userEmail
    }()
    
    private lazy var languageButton: UIButton = {
        let languageButton = ProfileButtons(title: String(localized:"Language"), picName: "greaterthan")
        languageButton.addTarget(self, action: #selector(languageTapped), for: .touchUpInside)
        
        return languageButton
    }()
    
    private lazy var termsButton: UIButton = {
        let termsButton = ProfileButtons(title: String(localized:"Terms & Conditions"), picName: "greaterthan")
        termsButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        
        return termsButton
    }()
    
    private lazy var signOutButton: UIButton = {
        let signOutButton = ProfileButtons(title: String(localized:"Sign Out"), picName: "rectangle.portrait.and.arrow.forward")
        signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        
        return signOutButton
    }()

    
   //MARK: - app load
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupNavBar()
        setupConstreints()
        loadUserData()
    }
    
    private func setupNavBar() {
        navigationBar.titleOfLabel.text = "Profile"
        navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(navigationBar)
        view.addSubview(navigationBar.view)
        navigationBar.didMove(toParent: self)
    }
    
//MARK: - buttons actions
    
    @objc func languageTapped(_ sender: UIButton) {
        let languageVC = LanguageVC()
        navigationController?.pushViewController(languageVC, animated: true)
    }
    
    @objc func termsTapped(_ sender: UIButton) {
        let termsVC = TermsAndConditionsVC()
        navigationController?.pushViewController(termsVC, animated: true)
    }
    
    @objc func signOutTapped(_ sender: UIButton) {
        guard
            let windowScene = view.window?.windowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
        else { return }

        AuthManager.shared.logout { [weak self] result in
            switch result {
            case .success:
                let vc = LoginViewController()
                sceneDelegate.window?.rootViewController = vc
            case .failure(let error):
                self?.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
    
 //MARK: - set constreints
    
    private func setupConstreints() {
        view.addSubview(fotoImage)
        view.addSubview(userName)
        view.addSubview(userEmail)
        view.addSubview(languageButton)
        view.addSubview(termsButton)
        view.addSubview(signOutButton)
        view.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        //fotoImage.translatesAutoresizingMaskIntoConstraints = false
        //userName.translatesAutoresizingMaskIntoConstraints = false
        //userEmail.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 50),
            
            fotoImage.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 30),
            fotoImage.widthAnchor.constraint(equalToConstant: 72),
            fotoImage.heightAnchor.constraint(equalTo: fotoImage.widthAnchor),
            fotoImage.leadingAnchor.constraint(equalTo: navigationBar.view.leadingAnchor, constant: 20),
            
            userName.bottomAnchor.constraint(equalTo: fotoImage.centerYAnchor),
            userName.leadingAnchor.constraint(equalTo: fotoImage.trailingAnchor, constant: 24),
            userName.trailingAnchor.constraint(equalTo: navigationBar.view.trailingAnchor),
            
            userEmail.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            userEmail.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            userEmail.trailingAnchor.constraint(equalTo: userName.trailingAnchor),
            
            languageButton.topAnchor.constraint(equalTo: fotoImage.bottomAnchor, constant: 44),
            languageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            signOutButton.centerXAnchor.constraint(equalTo: languageButton.centerXAnchor),
            signOutButton.widthAnchor.constraint(equalTo: languageButton.widthAnchor),
            
            termsButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -28),
            termsButton.centerXAnchor.constraint(equalTo: signOutButton.centerXAnchor),
            termsButton.widthAnchor.constraint(equalTo: signOutButton.widthAnchor)
        ])
    }
}

// MARK: - Load data

extension ProfileViewController {
    private func loadUserData() {
        guard let user = AuthManager.shared.currentUser else { return }

        FirestoreManager.shared.getUserData(userID: user.uid) { [weak self] result in
            switch result {
            case .success(let userData):
                if let username = userData["username"] as? String {
                    self?.userName.text = username
                }

                self?.userEmail.text = user.email

            case .failure(let error):
                self?.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
}
