//
//  ProfileViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let navigationBar = CustomNavigationBar()
    private var user: User?
    
    private let fotoImage: UIImageView = {
        let fotoImage = UIImageView()
        fotoImage.contentMode = .scaleAspectFill
        fotoImage.image = UIImage(named: "userImage")
        fotoImage.tintColor = .gray
        fotoImage.isUserInteractionEnabled = true
       
        return fotoImage
    }()
    
    private let userName: UITextField = {
        let userName = UITextField()
        userName.font = .systemFont(ofSize: 16, weight: .semibold)
        userName.textColor = .black
        userName.returnKeyType = .done
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
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupNavBar()
        setupConstreints()
    }
    
    private func setupNavBar() {
        navigationBar.titleOfLabel.text = "Profile"
        navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(navigationBar)
        view.addSubview(navigationBar.view)
        navigationBar.didMove(toParent: self)
    }
    
    private func setupConstreints() {
        view.addSubview(fotoImage)
        view.addSubview(userName)
        view.addSubview(userEmail)
        
        fotoImage.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        
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
            userEmail.trailingAnchor.constraint(equalTo: userName.trailingAnchor)
            
        ])
    }
}
