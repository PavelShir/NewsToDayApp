//
//  FavoriteManager.swift
//  NewsToDayApp
//
//  Created by user on 27.10.2024.
//
//


import UIKit


final class FavoriteManager {
    
    static let shared = FavoriteManager()
    
    private var favoriteArticles: [Article] = []
    
    private let defaults = UserDefaults.standard
    private let bookmarksKey = "bookmarks"
    
    private init() {
        loadFavorites()
    }
    
    
    var bookmarksArray: [Article] {
        get {
            return favoriteArticles
        }
        set {
            favoriteArticles = newValue
            saveFavorites()
        }
    }
    
    
    func addToFavorites(article: Article) {
        guard !isFavorite(article: article) else { return }
        favoriteArticles.append(article)
        saveFavorites()
    }
    
    func removeFromFavorites(article: Article) {
        guard let index = favoriteArticles.firstIndex(of: article) else { return }
        favoriteArticles.remove(at: index)
        saveFavorites()
    }
    
    func isFavorite(article: Article) -> Bool {
        return favoriteArticles.contains(article)
    }
    

    private func saveFavorites() {
        do {
            let encodedData = try JSONEncoder().encode(favoriteArticles)
            defaults.set(encodedData, forKey: bookmarksKey)
        } catch {
            print("Ошибка при сохранении закладок: \(error)")
        }
    }
    
    private func loadFavorites() {
        guard let data = defaults.data(forKey: bookmarksKey) else { return }
        
        do {
            favoriteArticles = try JSONDecoder().decode([Article].self, from: data)
        } catch {
            print("Ошибка при загрузке закладок: \(error)")
        }
    }
}
