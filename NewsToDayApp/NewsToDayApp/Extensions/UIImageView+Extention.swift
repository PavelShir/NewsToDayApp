//
//  UIImageView+Extention.swift
//  NewsToDayApp
//
//  Created by user on 31.10.2024.
//

import UIKit

extension UIImageView {
    static func makeImage(named imageName: String = "image", cornerRadius: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
