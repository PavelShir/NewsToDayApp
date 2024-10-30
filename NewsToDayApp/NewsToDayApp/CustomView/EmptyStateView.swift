//
//  EmptyStateView.swift
//  NewsToDayApp
//
//  Created by user on 24.10.2024.
//

import UIKit

class EmptyStateView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "You haven't saved any articles yet. Start reading and bookmarking them now"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            emptyLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
            
        ])
    }
}
