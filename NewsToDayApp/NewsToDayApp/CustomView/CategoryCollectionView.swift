//
//  CategoryCollectionView.swift
//  NewsToDayApp
//
//  Created by user on 31.10.2024.
//

import UIKit

protocol CategoryCollectionViewDelegate: AnyObject {
    func didSelectArticle(_ arts: Article)
}


final class CategoryCollectionView: UIView {
    
    var collectionView: UICollectionView!
    private let networkManager = NetworkService.shared
    var favoriteManager = FavoriteManager.shared
    weak var delegate: CategoryCollectionViewDelegate?
    
    var articles: [Article] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
//    func loadArticles() {
//        networkManager.fetchAF { [weak self] result in
//            switch result {
//            case .success(let articles):
//                self?.articles = articles
//            case .failure(let error):
//                print("Error loading articles: \(error)")
//            }
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollection()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Property
    
    private func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        
        let selectedNews = articles[indexPath.row]
        
        cell.liked = favoriteManager.bookmarksArray.contains(selectedNews)
        cell.favoriteButton.setImage(cell.liked ? .bookmarkFill : .bookmarkOutline, for: .normal)
        cell.setupCell(selectedNews)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = articles[indexPath.item]
        delegate?.didSelectArticle(selectedCell)
    }
}
