//
//  LabelCategoriesCell.swift
//  NewsToDayApp
//
//  Created by user on 01.11.2024.
//

import UIKit

final class LabelCategoriesCell: UICollectionViewCell {
    
    
    static let identifier = "LabelCategory"
    private let labelCategory = UILabel.makeLabel(text: "", font: .systemFont(ofSize: 14), textColor: .brandBlackPrimary)
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .brandPurpleDark
                labelCategory.textColor = .brandGreyLighter
            } else {
                backgroundColor = .brandGreyLighter
                labelCategory.textColor = .brandBlackLight
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupUICell()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUICell() {
        backgroundColor = .brandGreyLighter
        labelCategory.textColor = .brandBlackLight
        layer.masksToBounds = false
        layer.cornerRadius = 18
        labelCategory.numberOfLines = 1
        labelCategory.textAlignment = .center
    }
    
    public func configure(with title: String) {
        labelCategory.text = title
    }
    
    private func setupViews() {
        contentView.addSubview(labelCategory)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelCategory.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelCategory.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelCategory.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelCategory.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
}
