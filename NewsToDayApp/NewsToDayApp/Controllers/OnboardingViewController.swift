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
        layout.minimumLineSpacing = 27
        layout.minimumInteritemSpacing = 27
        layout.sectionInset = .init(top: 0, left: 44, bottom: 0, right: 44)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.decelerationRate = .fast
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

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = K.Onboarding.spacingStackView
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(
            ofSize: K.Onboarding.fontSizeTitleLabel,
            weight: .bold
        )
        label.textColor = .brandBlackPrimary
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(
            ofSize: K.Onboarding.fontSizeDescriptionLabel,
            weight: .regular
        )
        label.numberOfLines = 0
        label.textColor = .brandGreyPrimary
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
        [collectionView, pageControl, stackView, nextButton].forEach { view.addSubview($0) }
        [titleLabel, descriptionLabel].forEach { stackView.addArrangedSubview($0) }
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
            stackView.topAnchor.constraint(
                equalTo: pageControl.bottomAnchor,
                constant: K.Onboarding.topMarginStackView
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Onboarding.horizontalMarginStackView
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Onboarding.horizontalMarginStackView
            ),
            nextButton.topAnchor.constraint(
                equalTo: stackView.bottomAnchor,
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
//            nextButton.bottomAnchor.constraint(
//                equalTo: view.bottomAnchor,
//                constant: -K.Onboarding.bottomMarginNextButton
//            ),
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
            UIView.animate(withDuration: 0.3) {
                self.collectionView.collectionViewLayout.invalidateLayout()
            }
        } else {
            //TODO: get started app
            let startingVC = TabBarViewController()
            startingVC.modalPresentationStyle = .fullScreen
            present(startingVC, animated: true)
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
        if selectedIndex == indexPath.item {
            CGSize(
                width: collectionView.frame.width * 0.8,
                height: collectionView.frame.height
            )
        } else {
            CGSize(
                width: collectionView.frame.width * 0.8,
                height: collectionView.frame.height * 0.85
            )
        }
    }

    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        if !decelerate {
            centerCurrentPage(scrollView: scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCurrentPage(scrollView: scrollView)
    }

    private func centerCurrentPage(scrollView: UIScrollView) {
        let centerX = scrollView.contentOffset.x + scrollView.bounds.size.width / 2
        let closestIndexPath = collectionView.indexPathForItem(
            at: CGPoint(x: centerX, y: scrollView.bounds.size.height / 2)
        )

        if let indexPath = closestIndexPath {
            collectionView.scrollToItem(
                at: indexPath,
                at: .centeredHorizontally,
                animated: true
            )
            selectedIndex = indexPath.item
            pageControl.currentPage = selectedIndex
            updateLabels(for: selectedIndex)
            UIView.animate(withDuration: 0.3) {
                self.collectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: OnboardingViewController())
}
