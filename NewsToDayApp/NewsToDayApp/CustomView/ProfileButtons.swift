//
//  ProfileButtons.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 30.10.2024.
//

import UIKit

class ProfileButtons: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.5 : 1.0 // Изменение прозрачности при нажатии
        }
    }
    
    convenience init(title: String, picName: String) {
        self.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        layer.cornerRadius = 12
        self.isUserInteractionEnabled = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(red: 0.4, green: 0.42, blue: 0.56, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        let indicatorImageView = UIImageView(image: UIImage(systemName: picName))
        indicatorImageView.tintColor = .gray
        indicatorImageView.contentMode = .scaleAspectFit
        
        addSubview(titleLabel)
        addSubview(indicatorImageView)
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            indicatorImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            indicatorImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        if picName == "greaterthan" {
            indicatorImageView.contentMode = .scaleToFill
            indicatorImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
            indicatorImageView.widthAnchor.constraint(equalTo: indicatorImageView.heightAnchor, multiplier: 0.5).isActive = true
        } else {
            indicatorImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            indicatorImageView.widthAnchor.constraint(equalTo: indicatorImageView.heightAnchor).isActive = true
        }
    }
}
