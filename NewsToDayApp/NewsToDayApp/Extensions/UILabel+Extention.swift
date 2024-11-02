//
//  UILabel+Extention.swift
//  NewsToDayApp
//
//  Created by user on 31.10.2024.
//

import UIKit

extension UILabel {
    static func makeLabelForCells(text: String = "", font: UIFont?, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeLabel(text: String = "", font: UIFont?, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
