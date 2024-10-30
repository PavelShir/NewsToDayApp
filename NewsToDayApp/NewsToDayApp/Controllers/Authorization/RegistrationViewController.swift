//
//  RegistrationViewController.swift
//  NewsToDayApp
//
//  Created by Churkin Vitaly on 27.10.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class RegistrationViewController: UIViewController {

    // MARK: - Outlets

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = K.Authorization.registerTitle
        label.font = UIFont.systemFont(
            ofSize: K.Authorization.fontSizeTitleLabel,
            weight: .bold
        )
        label.textColor = .brandBlackPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = K.Authorization.registerDescription
        label.numberOfLines = 0
        label.font = UIFont.systemFont(
            ofSize: K.Authorization.fontSizeDescriptionLabel,
            weight: .regular
        )
        label.textColor = .brandGreyPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let usernameTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: K.Authorization.placeholderName,
            icon: .iconUser
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: K.Authorization.placeholderEmail,
            icon: .iconEnvelope
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: K.Authorization.placeholderPassword,
            icon: .iconLock,
            isSecure: true
        )
        textField.textContentType = .oneTimeCode
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let repeatPasswordTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: K.Authorization.placeholderRepeatPassword,
            icon: .iconLock, isSecure: true
        )
        textField.textContentType = .oneTimeCode
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.Authorization.signUpButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: K.Authorization.fontSizeSign,
            weight: .bold
        )
        button.backgroundColor = .brandPurplePrimary
        button.layer.cornerRadius = K.Authorization.cornerRadiusSignButton
        button.addAction(
            UIAction { [weak self] _ in
                self?.handleSignUpButton()
            },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = K.Authorization.spacingStackView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = K.Authorization.signInLabel
        label.font = UIFont.systemFont(
            ofSize: K.Authorization.fontSizeSign,
            weight: .regular
        )
        label.textColor = .brandBlackLighter
        return label
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.Authorization.signInButtonTitle, for: .normal)
        button.setTitleColor(.brandBlackPrimary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: K.Authorization.fontSizeSign,
            weight: .regular
        )
        button.addAction(
            UIAction { [weak self] _ in
                self?.handleSignInButton()
            },
            for: .touchUpInside
        )
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
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
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: K.Authorization.topMarginTitleLabel
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Authorization.horizontalMarginTwenty
            ),
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: K.Authorization.topMarginDescriptionLabel
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Authorization.horizontalMarginTwenty
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Authorization.horizontalMarginTwenty
            ),
            usernameTextField.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: K.Authorization.topMarginUpperTextField
            ),
            usernameTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Authorization.horizontalMarginTwenty
            ),
            usernameTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Authorization.horizontalMarginTwenty
            ),
            usernameTextField.heightAnchor.constraint(
                equalToConstant: K.Authorization.heightTextField
            ),
            emailTextField.topAnchor.constraint(
                equalTo: usernameTextField.bottomAnchor,
                constant: K.Authorization.topMarginInteriorTextField
            ),
            emailTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Authorization.horizontalMarginTwenty
            ),
            emailTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Authorization.horizontalMarginTwenty
            ),
            emailTextField.heightAnchor.constraint(
                equalToConstant: K.Authorization.heightTextField
            ),
            passwordTextField.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: K.Authorization.topMarginInteriorTextField
            ),
            passwordTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Authorization.horizontalMarginTwenty
            ),
            passwordTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Authorization.horizontalMarginTwenty
            ),
            passwordTextField.heightAnchor.constraint(
                equalToConstant: K.Authorization.heightTextField
            ),
            repeatPasswordTextField.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: K.Authorization.horizontalMarginTwenty
            ),
            repeatPasswordTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Authorization.horizontalMarginTwenty
            ),
            repeatPasswordTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Authorization.horizontalMarginTwenty
            ),
            repeatPasswordTextField.heightAnchor.constraint(
                equalToConstant: K.Authorization.heightTextField
            ),
            signUpButton.topAnchor.constraint(
                equalTo: repeatPasswordTextField.bottomAnchor,
                constant: K.Authorization.topMarginSignButton
            ),
            signUpButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Authorization.horizontalMarginTwenty
            ),
            signUpButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Authorization.horizontalMarginTwenty
            ),
            signUpButton.heightAnchor.constraint(
                equalToConstant:  K.Authorization.heightSignButton
            ),
            stackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            stackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -K.Authorization.bottomMarginStackView
            )
        ])
    }
}

// MARK: - Actions

private extension RegistrationViewController {
    func handleSignUpButton() {
        guard
            let username = usernameTextField.text, !username.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty
        else {
            showAlert(title: "Ошибка", message: "Пожалуйста, заполните все поля.")
            return
        }

        guard password == repeatPassword else {
            showAlert(title: "Ошибка", message: "Пароли не совпадают.")
            return
        }

        // Показать индикатор загрузки
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        AuthManager.shared.register(email: email, password: password, username: username) { [weak self] result in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()

                switch result {
                case .success:
                    self?.showAlert(title: "Успех", message: "Аккаунт успешно создан!") {
                        self?.handleSignInButton()
                    }
                case .failure(let error):
                    self?.showAlert(title: "Ошибка", message: error.localizedDescription)
                }
            }
        }
    }

    func handleSignInButton() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Keyboard

extension RegistrationViewController {
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
}
