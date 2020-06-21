//
//  NetworkingManager.swift
//  Newsletter
//
//  Created by Виталий Сосин on 19.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class NetworkingManager {
    
    var onCompletion: (([Articles]) -> Void)?
    
    func fetchNews() {
        
        let urlString = apiKey
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error { print(error); return }
                if let response = response { print(response) }
                
                if let data = data {
                    if let news = self.parseJSON(data: data),
                        let articles = news.articles {
                        self.onCompletion?(articles)
                    }
                }
            }
        }.resume()
    }
    
    func parseJSON(data: Data) -> News? {
        
        let decoder = JSONDecoder()
        
        do {
            let news = try decoder.decode(News.self, from: data)
            return news
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
