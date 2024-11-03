//
//  NetworkManager.swift
//  NewsToDayApp
//
//  Created by user on 21.10.2024.
//


import UIKit
import Alamofire



class NetworkService {
    
    static let shared = NetworkService()
    
    
    private init() {}
    
    
    private func getApiKey() -> String? {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let apiKey = config["API_KEY"] as? String else {
            return nil
        }
        return apiKey
    }
    
    func fetchAF(completion: @escaping (Result<[Article], AFError>) -> Void) {
        guard let apiKey = getApiKey() else {
            print("API-ключ не найден")
            return
        }
        
        let URLString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"
        guard let url = URL(string: URLString) else { return }
        
        let decoder = JSONDecoder()
        
        AF.request(url)
            .validate()
            .responseDecodable(of: NewsResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let newsResponse):
                    print("Success: \(newsResponse)")
                    let filter = newsResponse.articles.filter { $0.author != "[Removed]" }
                    completion(.success(filter))
                case .failure(let error):
                    print("Error \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    //Для поиска по ключевым словам
    func fetchSearch(with query: String, completion: @escaping (Result<[Article], AFError>) -> Void) {
        guard let apiKey = getApiKey() else {
            print("API-ключ не найден")
            return
        }
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let URLString = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=\(apiKey)&q=\(query)"
        
        guard let url = URL(string: URLString) else { return }
        
        let decoder = JSONDecoder()
        
        AF.request(url)
            .validate()
            .responseDecodable(of: NewsResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let newsResponse):
                    print("Success: \(newsResponse)")
                    
                    completion(.success(newsResponse.articles))
                case .failure(let error):
                    print("Error \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    //Для отображения статей по категориям
    func fetchCategoryNews(with categoryName: String, completion: @escaping (Result<[Article], AFError>) -> Void) {
        guard let apiKey = getApiKey() else {
            print("API-ключ не найден")
            return
        }
        
        let baseURL = "https://newsapi.org/v2/top-headlines"
        let parameters: [String: String] = [
            "category": categoryName,
            "apiKey": apiKey,
            "country": "us"
        ]
        
        let decoder = JSONDecoder()
        
        
        AF.request(baseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: NewsResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let newsResponse):
                    let filter = newsResponse.articles.filter { $0.author != "[Removed]" }
                    completion(.success(filter))
                case .failure(let error):
                    print("Ошибка: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
}


extension Notification.Name {
    static let bookmarkStatusChanged = Notification.Name("bookmarkStatusChanged")
}
