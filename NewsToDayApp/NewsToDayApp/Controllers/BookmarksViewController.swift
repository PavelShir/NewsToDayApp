//
//  BookmarksViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//

import UIKit

class BookmarksViewController: UITableViewController {
    
    private var article: [Article] = []
    private let networkManager = NetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reusedID)
        fetchArticle()
    }
    
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
}

extension BookmarksViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reusedID, for: indexPath) as! CustomCell
        let arts = article[indexPath.row]
        cell.setupCell(article: arts )
        return cell
        
    }
    
}
