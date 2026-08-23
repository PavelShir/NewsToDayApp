//
//  LabelCategoryView.swift
//  NewsToDayApp
//
//  Created by user on 01.11.2024.
//

import UIKit

protocol LabelCategoryViewProtocol: AnyObject {
    func fetchCategory(categoryName: String)
    
}

final class LabelCategoryView: UIView {
    
    private var collectionView: UICollectionView!
    weak var delegate: LabelCategoryViewProtocol?
    
    private let categoryNames = ["General".localized(), "Business".localized(), "Entertainment".localized(), "Health".localized(), "Science".localized(), "Technology".localized(), "Sports".localized()]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollection()
        setupDelegates()
        
        addSubview(collectionView)
        
        setupConstraints()
        makeFirstCellActive()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(LabelCategoriesCell.self, forCellWithReuseIdentifier: LabelCategoriesCell.identifier)
    }
    
    func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    func makeFirstCellActive() {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .centeredHorizontally)
    }
    
}


extension LabelCategoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCategoriesCell.identifier, for: indexPath) as? LabelCategoriesCell else {
            return UICollectionViewCell()
        }
        
        let categoryCell = categoryNames[indexPath.row]
        cell.configure(with: categoryCell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categoryNames[indexPath.row]
        let cellWidth = text.size(withAttributes: [.font : UIFont.systemFont(ofSize: 16)]).width + 40
        return CGSize(width: cellWidth, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categoryNames[indexPath.item].lowercased()
            delegate?.fetchCategory(categoryName: selectedCategory)
    }
    
}
