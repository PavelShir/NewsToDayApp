//
//  AuthManager.swift
//  NewsToDayApp
//
//  Created by Churkin Vitaly on 30.10.2024.
//

import Foundation
import FirebaseAuth

final class AuthManager {

    static let shared = AuthManager()
    private let auth: Auth = .auth()

    var currentUser: User? { auth.currentUser }

    private init() {}

    func register(
        email: String,
        password: String,
        username: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let userID = authResult?.user.uid else {
                completion(.failure(
                    NSError(
                        domain: "AuthError",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Invalid user ID"]
                    )
                ))
                return
            }

            FirestoreManager.shared.saveUserData(userID: userID, username: username) { saveResult in
                switch saveResult {
                case .success:
                    // Пользователь успешно зарегистрирован и данные сохранены
                    // Разлогиниваем пользователя
                    self.logout { logoutResult in
                        switch logoutResult {
                        case .success:
                            completion(.success(()))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    self.logout { _ in
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    func login(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        auth.signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(()))
        }
    }

    func isUserLoggedIn() -> Bool {
        return auth.currentUser != nil
    }

    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
}

