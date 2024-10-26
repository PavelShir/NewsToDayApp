//
//  BrowseViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//

import UIKit

class BrowseViewController: UIViewController {
    
    private var articles: [Article] = []
    private let networkManager = NetworkService.shared
    private let navigationBar = CustomNavigationBar()
    private let searchBar = SearchBar()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBar()
        setupSearchBar()
        setupConstraints()
        
    }
    
    //MARK: - Setup UI
    private func setupNavBar() {
        navigationBar.titleOfLabel.text = "Browse"
        navigationBar.subTitleLabel.text = "Discover things of this world"
        navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(navigationBar)
        view.addSubview(navigationBar.view)
        navigationBar.didMove(toParent: self)
    }
    
    private func setupSearchBar() {
        searchBar.searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar.view)
        
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.view.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 20),
            searchBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searchBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
        ])
        
    }
    
}
