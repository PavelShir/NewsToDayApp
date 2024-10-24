//
//  CustomCell.swift
//  NewsToDayApp
//
//  Created by user on 21.10.2024.
//

import UIKit
import Kingfisher

final class CustomCell: UITableViewCell {
    
    static let reusedID = "CustomCell"
    
    var completion: (() -> Void)?
    
    private var customCellView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    lazy var customCellImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.heightAnchor.constraint(equalToConstant: 90).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 90).isActive = true
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: bounds))
    
    private lazy var customCellCaption = getLabel(font: UIFont.systemFont(ofSize: 14, weight: .light), color: .systemGray2)
    
    private lazy var customCellTitle = getLabel(font: UIFont.systemFont(ofSize: 16, weight: .bold), color: .black)
    
    private let labelStack: UIStackView = {
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.spacing = 8
        labelStack.distribution = .equalSpacing
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        return labelStack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(customCellView)
        
        //setupStack()
        setupLayout()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout() {
        [customCellImage, customCellTitle, customCellCaption].forEach { subView in
            customCellView.addSubview(subView)
        }
    }
    
    func setupStack() {
        labelStack.addArrangedSubview(customCellCaption)
        labelStack.addArrangedSubview(customCellTitle)
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
        
        customCellCaption.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            customCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            customCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            customCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            customCellImage.topAnchor.constraint(equalTo: customCellView.topAnchor),
            customCellImage.leadingAnchor.constraint(equalTo: customCellView.leadingAnchor),
            
            customCellCaption.topAnchor.constraint(equalTo: customCellView.topAnchor, constant: 8),
            customCellCaption.leadingAnchor.constraint(equalTo: customCellImage.trailingAnchor, constant: 16),
            customCellCaption.heightAnchor.constraint(equalToConstant: 20),
            
            customCellTitle.topAnchor.constraint(equalTo: customCellCaption.bottomAnchor, constant: 12),
            customCellTitle.leadingAnchor.constraint(equalTo: customCellImage.trailingAnchor, constant: 16),
            customCellTitle.trailingAnchor.constraint(equalTo: customCellView.trailingAnchor, constant: -12),
            
            
        ])
    }
    
    //MARK: - Private Methods
    
    private func getLabel(font: UIFont, color: UIColor) -> UILabel {
        {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = font
            $0.textColor = color
            $0.numberOfLines = 2
            $0.lineBreakMode = .byTruncatingTail
            return $0
            
        }(UILabel())
    }
}
