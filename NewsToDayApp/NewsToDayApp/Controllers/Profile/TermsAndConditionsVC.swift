//
//  TermsAndConditionsVC.swift
//  NewsToDayApp
//
//  Created by Сергей Сухарев on 28.10.2024.
//

import UIKit

class TermsAndConditionsVC: UIViewController {
    
    let buttonBack = UIButton()
    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupView()
        setupConstraints()
        configuration()
    }
    private func setupNavBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.brandBlackPrimary]
        title = "Terms & Conditions"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonBack)
    }
    private func setupView() {
        view.addSubview(textView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configuration() {
        buttonBack.setImage(UIImage.backButtonGray, for: .normal)
        buttonBack.addTarget(self, action: #selector (backButtonTapped), for: .touchUpInside)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ConstantAppString.text
        textView.textColor = .brandGreyPrimary
        textView.sizeToFit()
        textView.textContainerInset = UIEdgeInsets( top: 20, left: 20, bottom: 20, right: 20)
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.isEditable = false
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}
@available(iOS 17.0, *)
#Preview { UINavigationController(rootViewController: TermsAndConditionsVC())}
