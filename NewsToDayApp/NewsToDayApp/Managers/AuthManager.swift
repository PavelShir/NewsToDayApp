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

            completion(.success(()))
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
