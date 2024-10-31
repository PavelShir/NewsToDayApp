//
//  BrowseViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//

import UIKit

final class BrowseViewController: UIViewController {
    
    //MARK: - Private Property
    
    private var articles: [Article] = []
    private let networkManager = NetworkService.shared
    private let favoriteManager = FavoriteManager.shared
    
    private let navigationBar = CustomNavigationBar()
    private let searchBar = SearchBar()
    private let categoryCollectionView = CategoryCollectionView()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBar()
        setupSearchBar()
        setupCollectionView()
        setupConstraints()
        setupDelegate()
        
        fetchArticle()
    }
    
    //MARK: - Private Methods
    
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
    
    private func setupCollectionView() {
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryCollectionView)
    }
    
    private func setupDelegate() {
        categoryCollectionView.delegate = self
    }
    
    private func fetchArticle() {
        networkManager.fetchAF { [unowned self] result in
            switch result {
            case .success(let articles):
                self.categoryCollectionView.articles = articles
            case .failure(let error):
                print("Error loading articles: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 60),
            
            searchBar.view.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 20),
            searchBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searchBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            categoryCollectionView.topAnchor.constraint(equalTo: searchBar.view.bottomAnchor, constant: 20),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            categoryCollectionView.widthAnchor.constraint(greaterThanOrEqualToConstant: 3000),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 256),

        ])
    }
}

extension BrowseViewController: CategoryCollectionViewDelegate {
    func didSelectArticle(_ article: Article) {
        let articleVC = ArticleViewController(article: article)
        navigationController?.pushViewController(articleVC, animated: true)
    }
}
