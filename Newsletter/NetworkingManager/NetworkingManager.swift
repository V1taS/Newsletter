//
//  NetworkingManager.swift
//  Newsletter
//
//  Created by Виталий Сосин on 19.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func fetchNews(form urlString: String, with completion: @escaping ([Articles]) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error { print(error); return }
            if let response = response { print(response) }
            
            if let data = data {
                if let news = self.parseJSON(data: data),
                    let articles = news.articles {
                    completion(articles)
                }
            }
        }.resume()
    }
    
    func parseJSON(data: Data) -> News? {
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(News.self, from: data)
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func getAndSetImage(urlImage: String) -> UIImage? {
        guard let imageUrl = URL(string: urlImage) else { return nil }
        guard let imageData = try? Data(contentsOf: imageUrl) else { return nil }
        guard let image = UIImage(data: imageData) else { return nil }
        return image
    }
}
