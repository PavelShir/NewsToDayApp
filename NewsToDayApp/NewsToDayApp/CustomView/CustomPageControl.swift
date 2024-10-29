//
//  CustomPageControl.swift
//  NewsToDayApp
//
//  Created by Churkin Vitaly on 25.10.2024.
//

import UIKit

final class CustomAnimatedPageControl: UIView {

    var numberOfPages: Int = 0 {
        didSet {
            setupDots()
        }
    }

    var currentPage: Int = 0 {
        didSet {
            animateToCurrentPage()
        }
    }

    private var dotViews = [UIView]()
    private let dotSize: CGFloat = 8.0
    private let dotSpacing: CGFloat = 10.0
    private let selectedDotWidth: CGFloat = 24.0 // Выбранная точка шире в 3 раза

    // Настраиваем точки
    private func setupDots() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews.removeAll()

        for i in 0..<numberOfPages {
            let dotView = UIView()
            dotView.backgroundColor = i == currentPage ? .brandPurplePrimary : .brandGreyLight
            dotView.layer.cornerRadius = dotSize / 2
            dotView.translatesAutoresizingMaskIntoConstraints = false

            addSubview(dotView)
            dotViews.append(dotView)
        }

        setNeedsLayout()
        layoutIfNeeded()
        animateToCurrentPage()
    }

    // Анимируем изменение выбранной точки
    private func animateToCurrentPage() {
        for (index, dotView) in dotViews.enumerated() {
            if index == currentPage {
                UIView.animate(withDuration: 0.3, animations: {
                    dotView.frame.size.width = self.selectedDotWidth
                    dotView.layer.cornerRadius = self.dotSize / 2
                    dotView.backgroundColor = .systemIndigo
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    dotView.frame.size.width = self.dotSize
                    dotView.layer.cornerRadius = self.dotSize / 2
                    dotView.backgroundColor = .systemGray4
                })
            }
        }

        // После анимации - обновить layout для предотвращения наложения точек
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Общая ширина с учетом динамических размеров выбранной точки
        var totalWidth: CGFloat = 0.0
        for (index, _) in dotViews.enumerated() {
            totalWidth += (index == currentPage ? selectedDotWidth : dotSize) + dotSpacing
        }
        totalWidth -= dotSpacing // Убираем последний лишний отступ

        let startX = (bounds.width - totalWidth) / 2

        var xPosition = startX
        for (index, dotView) in dotViews.enumerated() {
            let width = index == currentPage ? selectedDotWidth : dotSize
            dotView.frame = CGRect(x: xPosition, y: (bounds.height - dotSize) / 2, width: width, height: dotSize)
            xPosition += width + dotSpacing
        }
    }
}
