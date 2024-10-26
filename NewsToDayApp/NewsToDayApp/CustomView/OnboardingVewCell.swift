//
//  OnboardingCell.swift
//  NewsToDayApp
//
//  Created by Churkin Vitaly on 21.10.2024.
//

import UIKit

final class OnboardingViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier: String = "OnboardingViewCell"

    // MARK: - Outlets

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = K.Onboarding.cornerRadiusImage
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initial

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Private func

    private func commonInit() {
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Settings

    private func setupHierarchy() {
        addSubview(imageView)

    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Public func (configuration)

    func configureView(with model: OnboardingModel) {
        imageView.image = UIImage(named: model.image)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: OnboardingViewController())
}
