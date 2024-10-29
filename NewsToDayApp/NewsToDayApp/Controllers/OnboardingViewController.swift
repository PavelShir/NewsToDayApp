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
                isLastPage ? "Next" : "Get Started",
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 10
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
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 76
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            collectionView.heightAnchor.constraint(
                equalToConstant: .init(336)
            ),
            pageControl.topAnchor.constraint(
                equalTo: collectionView.bottomAnchor,
                constant: 40
            ),
            pageControl.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            pageControl.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            titleLabel.topAnchor.constraint(
                equalTo: pageControl.bottomAnchor,
                constant: 34
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 34
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 100
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -100
            ),
            nextButton.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: 64
            ),
            nextButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            nextButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -50
            ),
            nextButton.heightAnchor.constraint(
                equalToConstant: .init(50)
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
