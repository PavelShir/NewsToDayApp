//
//  BookmarksViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    
    private var article: [Article] = []
    private let networkManager = NetworkService.shared
    let navigationBar = CustomNavigationBar()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
        
        fetchArticle()
        
        setupNavBar()
        setupTableView()
        setupEmptyStateView()
        setupConstraints()
        
    }
    
    
    //MARK: - Private Methods
    
    private func updateView() {
        if article.isEmpty {
            tableView.isHidden = true
            emptyStateView.isHidden = false
        } else {
            tableView.isHidden = false
            emptyStateView.isHidden = true
            tableView.reloadData()        }
    }
    
    
    private func fetchArticle() {
        networkManager.fetchAF { [unowned self] result in
            switch result {
            case .success(let article):
                self.article = article
                self.tableView.reloadData()
                self.updateView()
            case .failure(let error):
                print(error.localizedDescription)
                self.updateView()
            }
        }
    }
    
    //MARK: - Setup UI
    private func setupNavBar() {
        navigationBar.titleOfLabel.text = "Bookmarks"
        navigationBar.subTitleLabel.text = "Saved articles to the library"
        navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(navigationBar)
        view.addSubview(navigationBar.view)
        navigationBar.didMove(toParent: self)
    }
    
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reusedID)
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
    private func setupEmptyStateView() {
           view.addSubview(emptyStateView)
       }
    
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            
        ])
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension BookmarksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reusedID, for: indexPath) as! CustomCell
        let arts = article[indexPath.row]
        cell.setupCell(article: arts )
        return cell
    }
    
}

