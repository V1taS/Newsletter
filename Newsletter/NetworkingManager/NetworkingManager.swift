//
//  NetworkingManager.swift
//  Newsletter
//
//  Created by Виталий Сосин on 19.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import Alamofire

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    //MARK: - Менеджер парсинга Codable
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

    //MARK: - Парсинг данных через Codable
    func parseJSON(data: Data) -> News? {
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(News.self, from: data)
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    //MARK: - Получение изображения по ссылке
    func getAndSetImage(urlImage: String) -> UIImage? {
        guard let imageUrl = URL(string: urlImage) else { return nil }
        guard let imageData = try? Data(contentsOf: imageUrl) else { return nil }
        guard let image = UIImage(data: imageData) else { return nil }
        return image
    }
    
    //MARK: - Получение данных через alamofire
    func alamofireGetNews(from urlString: String, with complition: @escaping ([Articles]) -> Void) {
        
        AF.request(urlString)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let news = News.init(dictNews: value as! [String : Any])
                    complition(news.articles ?? [])
                case .failure(let error):
                    print(error)
                }
        }
    }
}
