//
//  News.swift
//  NewsApp
//
//  Created by Aditya Jha on 06/01/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import Foundation

struct News: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Articles]?
    
    enum CodingKeys: String, CodingKey {
        case status, totalResults, articles
    }
    
}

struct Articles: Decodable {
    var title: String?
    var author: String?
    var publishedAt: String?
    var urlToImage: String?
    var description: String?
    var content: String?
        
    enum CodingKeys: String, CodingKey {
        case title, author, publishedAt,urlToImage,description,content
    }
}
