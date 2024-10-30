//
//  CollectionCell.swift
//  NewsToDayApp
//
//  Created by user on 27.10.2024.
//


import UIKit
import Kingfisher

class CollectionCell: UICollectionViewCell {
    
    
    static let identifier = "CollectionCell"
    
    //MARK: - Private Property
    
    private let favoriteManager = FavoriteManager.shared
    
    private let imageCollectionCell = UIImageView.makeImage(cornerRadius: 12)
    private let labelTitle = UILabel.makeLabelForCells(
        font: UIFont.systemFont(ofSize: 20),
        textColor: .white
    )
    
    private let labelCaption = UILabel.makeLabelForCells(
        font: UIFont.systemFont(ofSize: 16),
        textColor: .systemGray5
    )
    
    private let darkOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let options: KingfisherOptionsInfo = [.cacheOriginalImage]
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var liked: Bool = false
    var currentArticle: Article?
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func favoriteButtonTapped() {
        guard let article = currentArticle else { return }
        
        if liked {
            favoriteManager.removeFromFavorites(article: article)
            liked = false
            favoriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        } else {
            favoriteManager.addToFavorites(article: article)
            liked = true
            favoriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
    }
    
    
    //MARK: - Setup UI
    
    private func setupViews() {
        contentView.addSubview(imageCollectionCell)
        imageCollectionCell.addSubview(darkOverlayView)
        imageCollectionCell.addSubview(labelTitle)
        imageCollectionCell.addSubview(labelCaption)
        imageCollectionCell.addSubview(favoriteButton)
    }
    
    func setupCell(_ data: Article) {
        DispatchQueue.main.async {
            self.labelCaption.text = data.description
            self.labelTitle.text = data.title
            self.imageCollectionCell.kf.setImage(
                with: URL(string: data.urlToImage ?? "placeholder"),
                options: self.options
            )
            self.currentArticle = data
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCollectionCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollectionCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollectionCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollectionCell.heightAnchor.constraint(equalToConstant: 250),
            
            darkOverlayView.topAnchor.constraint(equalTo: imageCollectionCell.topAnchor),
            darkOverlayView.leadingAnchor.constraint(equalTo: imageCollectionCell.leadingAnchor),
            darkOverlayView.trailingAnchor.constraint(equalTo: imageCollectionCell.trailingAnchor),
            darkOverlayView.bottomAnchor.constraint(equalTo: imageCollectionCell.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: imageCollectionCell.topAnchor, constant: 12),
            favoriteButton.trailingAnchor.constraint(equalTo: imageCollectionCell.trailingAnchor, constant: -12),
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32),
            
            labelTitle.bottomAnchor.constraint(equalTo: imageCollectionCell.bottomAnchor, constant: -12),
            labelTitle.leadingAnchor.constraint(equalTo: imageCollectionCell.leadingAnchor, constant: 12),
            labelTitle.trailingAnchor.constraint(equalTo: imageCollectionCell.trailingAnchor, constant: -8),
            labelTitle.heightAnchor.constraint(equalToConstant: 50),
            
            labelCaption.bottomAnchor.constraint(equalTo: labelTitle.topAnchor, constant: -10),
            labelCaption.leadingAnchor.constraint(equalTo: imageCollectionCell.leadingAnchor, constant: 8),
            labelCaption.trailingAnchor.constraint(equalTo: imageCollectionCell.trailingAnchor, constant: -8),
            labelCaption.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}



