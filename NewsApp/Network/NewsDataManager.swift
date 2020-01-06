//
//  NewsDataManager.swift
//  NewsApp
//
//  Created by Aditya Jha on 06/01/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import Foundation

final class NewsDataManager {
    
    private let apiClient: NewsAPIClient!
    
    private let API_KEY = "4af144f691d544769301686008aa12e7"

    
    init(apiClient: NewsAPIClient) {
        self.apiClient = apiClient
    }
    
    func getNewsList(_ completion: @escaping ((Result<News>) -> Void)) {
        let resource = Resource(url: URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=\(API_KEY)")!)
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(News.self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
