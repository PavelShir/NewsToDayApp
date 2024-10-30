//
//  LoginViewController.swift
//  NewsToDayApp
//
//  Created by Churkin Vitaly on 27.10.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class LoginViewController: UIViewController {

    // MARK: - Outlets

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = K.Authorization.loginTitle
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
        label.text = K.Authorization.loginDescription
        label.numberOfLines = 0
        label.font = UIFont.systemFont(
            ofSize: K.Authorization.fontSizeDescriptionLabel,
            weight: .regular
        )
        label.textColor = .brandGreyPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: K.Authorization.placeholderEmail,
            icon: .iconEnvelope
        )
        textField.text = "user@example.com" // TODO: Use temporary data for development. Remove this line before production.
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: K.Authorization.placeholderPassword,
            icon: .iconLock,
            isSecure: true
        )
        textField.addAction(
            UIAction { [weak self] _
                in self?.setupPasswordObservers()
            },
            for: .editingChanged
        )
        textField.autocapitalizationType = .none
        textField.text = "123456" // TODO: Use temporary data for development. Remove this line before production.
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var togglePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .brandPurplePrimary
        button.addAction(
            UIAction { [weak self] _ in
                self?.togglePasswordVisibility()
            },
            for: .touchUpInside
        )
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.Authorization.signInButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: K.Authorization.fontSizeSign,
            weight: .bold
        )
        button.backgroundColor = .brandPurplePrimary
        button.layer.cornerRadius = K.Authorization.cornerRadiusSignButton
        button.addAction(
            UIAction { [weak self] _ in
                self?.handleSignInButton()
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

    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = K.Authorization.signUpLabel
        label.font = UIFont.systemFont(
            ofSize: K.Authorization.fontSizeSign,
            weight: .regular
        )
        label.textColor = .brandBlackLighter
        return label
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.Authorization.signUpButtonTitle, for: .normal)
        button.setTitleColor(.brandBlackPrimary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: K.Authorization.fontSizeSign,
            weight: .regular
        )
        button.addAction(
            UIAction { [weak self] _ in
                self?.handleSignUpButton()
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
        setupPasswordObservers()
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
            emailTextField,
            passwordTextField,
            togglePasswordButton,
            signInButton,
            stackView
        ].forEach { view.addSubview($0) }
        [
            signUpLabel,
            signUpButton
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
            emailTextField.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: K.Authorization.topMarginUpperTextField
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
            togglePasswordButton.centerYAnchor.constraint(
                equalTo: passwordTextField.centerYAnchor
            ),
            togglePasswordButton.trailingAnchor.constraint(
                equalTo: passwordTextField.trailingAnchor,
                constant: -K.Authorization.rightMarginToggleButton
            ),
            togglePasswordButton.heightAnchor.constraint(
                equalToConstant: K.Authorization.heightToggleButton
            ),
            signInButton.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: K.Authorization.topMarginSignButton
            ),
            signInButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: K.Authorization.horizontalMarginTwenty
            ),
            signInButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -K.Authorization.horizontalMarginTwenty
            ),
            signInButton.heightAnchor.constraint(
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

    private func setupPasswordObservers() {
        passwordTextField.addAction(UIAction { [weak self] _ in self?.passwordTextFieldDidChange() }, for: .editingChanged)
    }
}

// MARK: - Actions

private extension LoginViewController {
    func handleSignInButton() {
        guard
            let windowScene = view.window?.windowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
        else { return }

        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            showAlert(title: "Ошибка", message: "Пожалуйста, заполните все поля.")
            return
        }

        AuthManager.shared.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                let vc = OnboardingViewController()
                sceneDelegate.window?.rootViewController = vc
            case .failure(let error):
                self?.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }

    func handleSignUpButton() {
        let registrationViewController = RegistrationViewController()
        registrationViewController.modalPresentationStyle = .fullScreen
        present(registrationViewController, animated: true, completion: nil)
    }

    func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let image = passwordTextField.isSecureTextEntry ? "eye.slash": "eye"
        togglePasswordButton.setImage(UIImage(systemName: image), for: .normal)
    }

    func passwordTextFieldDidChange() {
        togglePasswordButton.isHidden = passwordTextField.text?.isEmpty ?? true
    }
}

// MARK: - Keyboard

extension LoginViewController {
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
}
