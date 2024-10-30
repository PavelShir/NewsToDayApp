//
//  CategoriesSetting.swift
//  NewsToDayApp
//
//  Created by Дмирий Зядик on 27.10.2024.
//

import Foundation

final class CategoriesSetting {
    static let shared = CategoriesSetting()
    
    private var defaultSetting: Set<String>
    
    private init () {
        defaultSetting = []
    }
    
    func getSettingLoad() -> Set<String> {
        let decoder = JSONDecoder()
        
        if let categoriesSetting = UserDefaults.standard.data(forKey: "categoriesSettins"),
           let settings = try? decoder.decode(Set<String>.self, from: categoriesSetting){
            return settings
        }
        
        return defaultSetting
    }
    
    func saveSettings(_ settings: Set<String>){
        let encoder = JSONEncoder()
        if let encodedCategoriesSetting = try? encoder.encode(settings){
            UserDefaults.standard.set(encodedCategoriesSetting, forKey: "categoriesSettins")
        }
    }
}
