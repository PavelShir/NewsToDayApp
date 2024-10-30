//
//  SearchBar.swift
//  NewsToDayApp
//
//  Created by user on 25.10.2024.
//

import UIKit

final class SearchBar: UIViewController, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    private var articles: [Article] = []
    private let networkManager = NetworkService.shared
    
    //MARK: - - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        setupSearchBar()
        setupTextField()
        setConstraints()
    }
    
    
    //MARK: - Private Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text, !searchTerm.isEmpty {
            loadArticle(searchTerm)
        }
    }
    
    private func loadArticle(_ text: String) {
        
        networkManager.fetchSearch(with: text) { [unowned self] result in
            switch result {
            case .success(let article):
                self.articles = article
                self.presentSearchScreen()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: - Setup UI
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = .black
        
        view.addSubview(searchBar)
    }
    
    private func setupTextField() {
        if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.backgroundColor = .systemGray6
            searchBarTextField.textColor = .black
            searchBarTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [.foregroundColor: UIColor.lightGray])
            searchBarTextField.layer.cornerRadius = 12
            if let glassIconView = searchBarTextField.leftView as? UIImageView {
                glassIconView.tintColor = .darkGray
            }
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 56),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchBar.searchTextField.topAnchor.constraint(equalTo: searchBar.topAnchor),
            searchBar.searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            searchBar.searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            searchBar.searchTextField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
            
        ])
    }
    
   
    private func presentSearchScreen() {
        let searchResultVC = SearchViewController()
        searchResultVC.articles = articles
        searchResultVC.modalPresentationStyle = .pageSheet
        present(searchResultVC, animated: true, completion: nil)
    }
}
