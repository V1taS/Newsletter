//
//  NetworkingManager.swift
//  Newsletter
//
//  Created by Виталий Сосин on 19.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol NetworkingManagerDelegate: class {
    func updateInterface(with news: [News])
}

class NetworkingManager {
    
    var delegate: NetworkingManagerDelegate?
    
    func fetchNews() {
        
        let urlString = apiKey
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error { print(error); return }
            if let response = response { print(response) }
            
            if let data = data {
                if let news = self.parseJSON(data: data) {
                    self.delegate?.updateInterface(with: news)
                }
            }
        }.resume()
    }
    
    func parseJSON(data: Data) -> [News]? {
        
        let decoder = JSONDecoder()
        
        do {
            let news = try decoder.decode([News].self, from: data)
            return news
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
