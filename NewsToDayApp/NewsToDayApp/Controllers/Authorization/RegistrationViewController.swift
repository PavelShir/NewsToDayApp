//
//  RegistrationViewController.swift
//  NewsToDayApp
//
//  Created by Churkin Vitaly on 27.10.2024.
//

import UIKit

final class RegistrationViewController: UIViewController {

    // MARK: - Outlets

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to NewsToDay"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .brandBlackPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, I guess you are new around here. You can start using the application after sign up."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .brandGreyPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let usernameTextField: UITextField = {
        let textField = UITextField()
        let userIcon: UIImage = .iconUser
        textField.setLeftIcon(userIcon)
        textField.setPlaceholder(text: "Username", color: .brandGreyPrimary)
        textField.textAlignment = .left
        textField.textColor = .brandBlackPrimary
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .brandGreyLighter
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        let envelopeIcon: UIImage = .iconEnvelope
        textField.setLeftIcon(envelopeIcon)
        textField.setPlaceholder(text: "Email Adress", color: .brandGreyPrimary)
        textField.textAlignment = .left
        textField.textColor = .brandBlackPrimary
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .brandGreyLighter
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        let lockIcon: UIImage = .iconLock
        textField.setLeftIcon(lockIcon)
        textField.setPlaceholder(text: "Password", color: .brandGreyPrimary)
        textField.textAlignment = .left
        textField.textColor = .brandBlackPrimary
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .brandGreyLighter
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        let lockIcon: UIImage = .iconLock
        textField.setLeftIcon(lockIcon)
        textField.setPlaceholder(text: "Repeat Password", color: .brandGreyPrimary)
        textField.textAlignment = .left
        textField.textColor = .brandBlackPrimary
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .brandGreyLighter
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .brandPurplePrimary
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .brandBlackLighter
        return label
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.brandBlackPrimary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.addAction(UIAction { _ in self.handleSignUpButton() }, for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        [
            titleLabel,
            descriptionLabel,
            usernameTextField,
            emailTextField,
            passwordTextField,
            repeatPasswordTextField,
            signUpButton,
            stackView
        ].forEach { view.addSubview($0) }
        [
            signInLabel,
            signInButton
        ].forEach { stackView.addArrangedSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            signUpButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 64),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant:  56),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42)
        ])
    }
}

// MARK: - Actions

private extension RegistrationViewController {
    func handleSignUpButton() {
        dismiss(animated: true, completion: nil)
    }
}
