//
//  News.swift
//  Newsletter
//
//  Created by Виталий Сосин on 19.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

struct News: Decodable {
    let articles: [Articles]?
}

struct Articles: Decodable {
    var title: String?
    let urlToImage: String?
    let description: String?
}
