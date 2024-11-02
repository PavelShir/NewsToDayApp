//
//  SearchViewController.swift
//  NewsToDayApp
//
//  Created by user on 25.10.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchTableView = UITableView()
    private let navigationBar = CustomNavigationBar()
    var articles: [Article] = []
    
    //MARK: - Private Property
    
    private lazy var emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBar()
        setupTableView()
        
        searchTableView.reloadData()
        
        emptyStateView.isHidden = !articles.isEmpty
        view.addSubview(emptyStateView)
       
        setConstraints()
    }
    
    
    //MARK: - Setup UI
    
    private func setupTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reusedID)
        view.addSubview(searchTableView)
        
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupNavBar() {
        navigationBar.titleOfLabel.text = "Search Results"
        navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(navigationBar)
        view.addSubview(navigationBar.view)
        navigationBar.didMove(toParent: self)
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
          
            navigationBar.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 70),
            
            
            searchTableView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emptyStateView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reusedID, for: indexPath) as! CustomCell
        
        if articles.count > 0 {
            let arts = articles[indexPath.row]
            cell.setupCell(article: arts)
        } else {
            emptyStateView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if articles.count > 0 {
            
            let selectedCell = articles[indexPath.item]
            let articleVC = ArticleViewController(article: selectedCell)
            
            if let navigationController = navigationController {
                navigationController.pushViewController(articleVC, animated: true)
            } else {
                print("Ошибка: NavigationController не найден.")
            }
            
            
            
//            let articleVC = ArticleViewController(article: selectedCell)
//        
//            articleVC.article = selectedCell
//            articleVC.modalPresentationStyle = .fullScreen
//            present(articleVC, animated: true, completion: nil)
        }
    }
}

