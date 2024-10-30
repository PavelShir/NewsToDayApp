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
        setConstraints()
        
        searchTableView.reloadData()
        
        emptyStateView.isHidden = !articles.isEmpty
        view.addSubview(emptyStateView)
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
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if articles.count > 0 {
            return articles.count
        } else {
            return 1
        }
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
            //Здесь создаем экземпляр контроллера для перехода на экран со статьей
            let articleVC = ArticleViewController(article: selectedCell)
            articleVC.article = selectedCell
            articleVC.modalPresentationStyle = .fullScreen
            present(articleVC, animated: true, completion: nil)
        }
    }
}
