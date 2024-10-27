//
//  UITextField+Extenstion.swift
//  NewsToDayApp
//
//  Created by Churkin Vitaly on 27.10.2024.
//

import UIKit

extension UITextField {
    private struct IconColors {
        static var defaultColor: UIColor = .brandGreyPrimary
        static var filledColor: UIColor = .brandPurplePrimary
    }

    func setLeftIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 16, y: 0, width: 24, height: 24))
        iconView.image = image.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = IconColors.defaultColor

        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
        iconContainerView.addSubview(iconView)

        leftView = iconContainerView
        leftViewMode = .always

        // Добавляем целевой метод для изменения цвета иконки при изменении текста
        addAction(UIAction { _ in self.textDidChange() }, for: .editingChanged)
    }

    private func textDidChange() {
        guard let iconView = (leftView)?.subviews.first as? UIImageView else { return }

        // Изменяем цвет иконки в зависимости от наличия текста
        iconView.tintColor = text?.isEmpty == false ? IconColors.filledColor : IconColors.defaultColor
    }

    func setPlaceholder(text: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: color]
        )
    }
}
