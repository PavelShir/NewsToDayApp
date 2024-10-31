//
//  LanguageVC.swift
//  NewsToDayApp
//
//  Created by Сергей Сухарев on 28.10.2024.
//

import UIKit

class LanguageVC: UIViewController {
    
    let buttonRu = UIButton()
    let buttonEn = UIButton()
    let buttonBack = UIButton()
    
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
        title = "Language"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonBack)
    }
    private func setupView() {
        view.addSubview(buttonRu)
        view.addSubview(buttonEn)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonEn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            buttonEn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonEn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonEn.heightAnchor.constraint(equalToConstant: 56),
            
            buttonRu.topAnchor.constraint(equalTo: buttonEn.bottomAnchor, constant: 16),
            buttonRu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonRu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonRu.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    private func configuration() {
        buttonBack.setImage(UIImage.backButtonGray, for: .normal)
        buttonBack.addTarget(self, action: #selector (backButtonTapped), for: .touchUpInside)
        
        buttonRu.setTitle("Russian", for: .normal)
        buttonRu.setImage(.checkGray, for: .normal)
        buttonRu.titleEdgeInsets = UIEdgeInsets(top: 0, left: -230, bottom: 0, right: 0)
        buttonRu.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -230)
        buttonRu.addTarget(self, action: #selector(buttonRuTapped), for: .touchUpInside)
        buttonRu.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        buttonRu.setTitleColor(UIColor.brandGreyDark, for: .normal)
        buttonRu.layer.borderColor = UIColor.black.cgColor
        buttonRu.layer.borderWidth = 1
        buttonRu.semanticContentAttribute = .forceRightToLeft
        buttonRu.layer.cornerRadius = 12
        buttonRu.backgroundColor = .brandGreyLighter
        buttonRu.translatesAutoresizingMaskIntoConstraints = false
        
        buttonEn.setTitle("English", for: .normal)
        buttonEn.setImage(.checkGray, for: .normal)
        buttonEn.addTarget(self, action: #selector(buttonEnTapped), for: .touchUpInside)
        buttonEn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        buttonEn.setTitleColor(UIColor.brandGreyDark, for: .normal)
        buttonEn.layer.borderColor = UIColor.black.cgColor
        buttonEn.layer.borderWidth = 1
        buttonEn.semanticContentAttribute = .forceRightToLeft
        buttonEn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -230, bottom: 0, right: 0)
        buttonEn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -230)
        buttonEn.layer.cornerRadius = 12
        buttonEn.backgroundColor = .brandGreyLighter
        buttonEn.translatesAutoresizingMaskIntoConstraints = false
    }
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func buttonEnTapped() {
        //buttonEn.setImage(.check, for: .normal)
        buttonEn.setImage(.check, for: .highlighted)
        buttonRu.setImage(.checkGray, for: .normal)
//        buttonEn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -230)
        buttonEn.backgroundColor = .brandPurplePrimary
        buttonRu.backgroundColor = .brandGreyLighter
        buttonEn.layer.borderWidth = 0
        buttonRu.layer.borderWidth = 1
        buttonEn.setTitleColor(.white, for: .normal)
        buttonRu.setTitleColor(.brandGreyDark, for: .normal)
    }
    
    @objc private func buttonRuTapped() {
//        buttonRu.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -230)
       // buttonEn.setImage(.check, for: .highlighted)
        buttonEn.setImage(.checkGray, for: .normal)
        buttonRu.setImage(.check, for: .highlighted)
        buttonRu.backgroundColor = .brandPurplePrimary
        buttonEn.backgroundColor = .brandGreyLighter
        buttonRu.layer.borderWidth = 0
        buttonEn.layer.borderWidth = 1
        buttonRu.setTitleColor(.white, for: .normal)
        buttonEn.setTitleColor(.brandGreyDark, for: .normal)
        
    }
}
@available(iOS 18.0, *)
#Preview { UINavigationController(rootViewController: LanguageVC())}

