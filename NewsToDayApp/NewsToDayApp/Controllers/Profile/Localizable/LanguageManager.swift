//
//  LanguageManager.swift
//  NewsToDayApp
//
//  Created by Сергей Сухарев on 31.10.2024.
//

import Foundation
enum Language: String {
    case en
    case ru
}

struct LanguageManager {
    static private(set) var currentLanguage = UserDefaults.standard.string(forKey: "currentLanguage") ?? "en"

    static func setCurrentLanguage(_ language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: "currentLanguage")
        currentLanguage = UserDefaults.standard.string(forKey: "currentLanguage") ?? "en"
    }
}

extension String {
    func localized() -> String {
        let path = Bundle.main.path(forResource: LanguageManager.currentLanguage, ofType: "lproj")
        guard let bundle = Bundle(path: path!) else { return self }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
