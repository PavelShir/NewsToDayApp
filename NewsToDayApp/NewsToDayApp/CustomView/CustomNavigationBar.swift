//
//  CustomNavigationBar.swift
//  NewsToDayApp
//
//  Created by user on 23.10.2024.
//


import UIKit

class CustomNavigationBar: UIViewController {
    
    let navigationBar = UINavigationBar()
    var textToShare = ""
    
    lazy var titleOfLabel: UILabel = {
        let label = UILabel()
        label.text = "Screen Name"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    
    lazy var subTitleLabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
        
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
        
    }
    
    
    
    private func setupNavigationBar() {
        
        navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()
        
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        
      
        navigationBar.backgroundColor = .clear
        navigationBar.addSubview(titleOfLabel)
        navigationBar.addSubview(subTitleLabel)
        view.addSubview(navigationBar)
        
    }
    
    
    private func setupLayout() {
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        titleOfLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 50),
            
            titleOfLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleOfLabel.heightAnchor.constraint(equalToConstant: 20),
            titleOfLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleOfLabel.bottomAnchor, constant: 12),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            
        ])
    }
}
