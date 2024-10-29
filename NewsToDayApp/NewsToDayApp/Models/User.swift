//
//  User.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 29.10.2024.
//

import UIKit

struct User: Codable, Equatable {
    var name: String
    let mail: String
    let password: String
    var photoName: String?
}
