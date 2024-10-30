//
//  UITextField+Extenstion.swift
//  NewsToDayApp
//
//  Created by Churkin Vitaly on 27.10.2024.
//

import UIKit

extension UITextField {
    private func setLeftIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 16, y: 0, width: 24, height: 24))
        iconView.image = image.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .brandGreyPrimary

        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 64, height: 24))
        iconContainerView.addSubview(iconView)

        leftView = iconContainerView
        leftViewMode = .always

        // Добавляем целевой метод для изменения цвета иконки при изменении текста
        addAction(UIAction { [weak self] _ in self?.textDidChange() }, for: .editingChanged)
    }

    private func textDidChange() {
        guard let iconView = (leftView)?.subviews.first as? UIImageView else { return }

        // Изменяем цвет иконки в зависимости от наличия текста
        iconView.tintColor = text?.isEmpty == false ? .brandPurplePrimary : .brandGreyPrimary
    }

    static func create(placeholder: String, icon: UIImage, isSecure: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.setLeftIcon(icon)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.brandGreyPrimary]
        )
        textField.textAlignment = .left
        textField.textColor = .brandBlackPrimary
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .brandGreyLighter
        textField.isSecureTextEntry = isSecure
        textField.autocapitalizationType = .none
        return textField
    }
}
