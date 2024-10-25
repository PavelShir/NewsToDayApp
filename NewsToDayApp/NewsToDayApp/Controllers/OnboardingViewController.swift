//
//  OnboardingViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {

    // MARK: - Properties

    private let models: [OnboardingModel] = OnboardingModel.models
    private var selectedIndex = 0 {
        didSet {
            let isLastPage = models.count - 1 > selectedIndex
            nextButton.setTitle(
                isLastPage ? K.Onboarding.titleNext : K.Onboarding.titleGetStarted,
                for: .normal
            )
        }
    }

    // MARK: - Outlets

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(
            OnboardingViewCell.self,
            forCellWithReuseIdentifier: OnboardingViewCell.identifier
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let pageControl: CustomAnimatedPageControl = {
        let page = CustomAnimatedPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(
            ofSize: K.Onboarding.fontSizeTitleLabel,
            weight: .bold
        )
        label.textColor = .brandBlackPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(
            ofSize: K.Onboarding.fontSizeDescriptionLabel,
            weight: .bold
        )
        label.numberOfLines = 0
        label.textColor = .brandGreyPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: K.Onboarding.fontSizeNextButton,
            weight: .bold
        )
        button.tintColor = .white
        button.backgroundColor = .brandPurplePrimary
        button.layer.cornerRadius = K.Onboarding.cornerRadiusNextButton
        button.addAction(
            UIAction { _ in self.handleNextButtonTapped() },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        updateLabels(for: selectedIndex)
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .white
        selectedIndex = 0
        pageControl.currentPage = selectedIndex
        pageControl.numberOfPages = models.count
    }

    private func setupHierarchy() {
        [
            collectionView,
            pageControl,
            titleLabel,
            descriptionLabel,
            nextButton
        ]
            .forEach { view.addSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: K.Onboarding.topMarginCollectionView
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            collectionView.heightAnchor.constraint(
                equalToConstant: K.Onboarding.heightCollectionView
            ),
            pageControl.topAnchor.constraint(
                equalTo: collectionView.bottomAnchor,
                constant: K.Onboarding.topMarginPageControl
            ),
            pageControl.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            pageControl.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            titleLabel.topAnchor.constraint(
                equalTo: pageControl.bottomAnchor,
                constant: K.Onboarding.topMarginTitleLabel
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: K.Onboarding.topMarginDescriptionLabel
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Onboarding.horizontalMarginDescriptionLabel
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Onboarding.horizontalMarginDescriptionLabel
            ),
            nextButton.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: K.Onboarding.topMarginNextButton
            ),
            nextButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Onboarding.horizontalMarginNextButton
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Onboarding.horizontalMarginNextButton
            ),
            nextButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -K.Onboarding.bottomMarginNextButton
            ),
            nextButton.heightAnchor.constraint(
                equalToConstant: K.Onboarding.heightNextButton
            )
        ])
    }

     // MARK: - Helper methods

    private func updateLabels(for index: Int) {
        guard index < models.count else { return }
        titleLabel.text = models[index].title
        descriptionLabel.text = models[index].description
    }

    // MARK: - Actions

    private func handleNextButtonTapped() {
        if selectedIndex < models.count - 1 {
            collectionView.scrollToItem(
                at: IndexPath(item: selectedIndex + 1, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
            selectedIndex += 1
            pageControl.currentPage += 1
            updateLabels(for: selectedIndex)
        } else {
            //TODO: get started app
        }
    }
}

// MARK: - Data Source

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return models.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnboardingViewCell.identifier,
            for: indexPath
        ) as? OnboardingViewCell else {
            return UICollectionViewCell()
        }
        cell.configureView(with: models[indexPath.row])
        return cell
    }
}

// MARK: - Delegate

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let newIndexOfPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = newIndexOfPage
        selectedIndex = newIndexOfPage
        updateLabels(for: selectedIndex)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: OnboardingViewController())
}
