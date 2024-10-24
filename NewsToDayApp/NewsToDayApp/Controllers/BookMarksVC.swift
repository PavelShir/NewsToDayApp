//
//  BookMarksVC.swift
//  NewsToDayApp
//
//  Created by user on 23.10.2024.
//

import UIKit

class BookMarksVC: UIViewController {
    
    private var article: [Article] = []
    private let networkManager = NetworkService.shared
    let navigationBar = CustomNavigationBar()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchArticle()
        
        setupNavBar()
        setupTableView()
        setupConstraints()
        
    }
    
    
    //MARK: - Private Methods
    
    private func fetchArticle() {
        networkManager.fetchAF { [unowned self] result in
            switch result {
            case .success(let article):
                self.article = article
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Setup UI
    private func setupNavBar() {
        navigationBar.titleOfLabel.text = "Name Screen"
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
    
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension BookMarksVC: UITableViewDataSource, UITableViewDelegate {
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
