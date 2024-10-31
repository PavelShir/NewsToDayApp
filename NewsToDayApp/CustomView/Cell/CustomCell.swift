//
//  CustomCell.swift
//  NewsToDayApp
//
//  Created by user on 21.10.2024.
//

import UIKit
import Kingfisher

final class CustomCell: UITableViewCell {
    
    var favoriteManager = FavoriteManager.shared
    var favoriteArticle: [Article] = []
    var currentArticle: Article?
    var liked: Bool = false
    static let reusedID = "CustomCell"
    
    
    //MARK: - Private Property
    private var customCellView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private let customCellImage = UIImageView.makeImage(cornerRadius: 20)
    
    private let customCellCaption = UILabel.makeLabelForCells(font: UIFont.systemFont(ofSize: 16), textColor: .brandBlackLighter)
    
    private lazy var customCellTitle = UILabel.makeLabelForCells(font: UIFont.systemFont(ofSize: 20), textColor: .brandBlackDark)
    
    let options: KingfisherOptionsInfo = [
        .cacheOriginalImage
    ]
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(customCellView)
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private Methods
    private func setupLayout() {
        [customCellImage, customCellTitle, customCellCaption].forEach { subView in
            customCellView.addSubview(subView)
        }
    }
    
    
    func setupCell(article: Article) {
        let imageURL = URL(string: article.urlToImage ?? "")
        customCellImage.kf.indicatorType = .activity
        let placeholderImage = UIImage(named: "placeholder")
        customCellImage.kf.setImage(
            with: imageURL,
            options: [
                KingfisherOptionsInfoItem
                    .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                    self.customCellImage.image = placeholderImage
                }
            }
        customCellCaption.text = article.author
        customCellTitle.text = article.description
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            customCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            customCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            customCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            customCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            customCellImage.topAnchor.constraint(equalTo: customCellView.topAnchor),
            customCellImage.leadingAnchor.constraint(equalTo: customCellView.leadingAnchor),
            customCellImage.heightAnchor.constraint(equalToConstant: 90),
            customCellImage.widthAnchor.constraint(equalToConstant: 90),
            
            
            customCellCaption.topAnchor.constraint(equalTo: customCellView.topAnchor, constant: 8),
            customCellCaption.leadingAnchor.constraint(equalTo: customCellImage.trailingAnchor, constant: 16),
            customCellCaption.heightAnchor.constraint(equalToConstant: 20),
            
            customCellTitle.topAnchor.constraint(equalTo: customCellCaption.bottomAnchor, constant: 12),
            customCellTitle.leadingAnchor.constraint(equalTo: customCellImage.trailingAnchor, constant: 16),
            customCellTitle.trailingAnchor.constraint(equalTo: customCellView.trailingAnchor, constant: -12),
            
        ])
    }
}
