//
//  News.swift
//  Newsletter
//
//  Created by Виталий Сосин on 19.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

struct News: Codable {
    let articles: [Articles]?
    
    init(dictNews: [String: Any]) {
        let articles = Articles.getNews(from: dictNews["articles"] as? [[String: Any]] ?? [])
        self.articles = articles
    }
}

struct Articles: Codable {
    var title: String?
    let urlToImage: String?
    let description: String?
    
    init(value: [String: Any]) {
        title = value["title"] as? String ?? ""
        urlToImage = value["urlToImage"] as? String ?? ""
        description = value["description"] as? String ?? ""
    }
    
    static func getNews(from value: [[String: Any]]) -> [Articles] {
        value.compactMap { Articles(value: $0)
        }
    }
}
