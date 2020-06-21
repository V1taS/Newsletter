//
//  NewsTableViewController.swift
//  Newsletter
//
//  Created by Виталий Сосин on 19.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let networkManager = NetworkingManager()
    private var news = [Articles]()
    
    var onCompletion: ((Articles) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.fetchNews()
        
        networkManager.onCompletion = { news in
            self.news = news
            self.tableView.reloadData()
        }
    }
    @IBAction func goButton() {
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        let currentNews = news[indexPath.row]
        
        cell.titleLabel.text = currentNews.title
        cell.contentLabel.text = currentNews.description
        cell.buttonOutlet.layer.cornerRadius = cell.frame.height / 50
        
        getAndSetImage(news: news, cell: cell, indexPath: indexPath)
        onCompletion?(currentNews)
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        if segue.identifier == "DescriptionSegue" {
            let descriptionVC = segue.destination as! DescriptionViewController
            descriptionVC.indexPath = indexPath?.row
        }
    }
    
    // MARK: - Get image
    private func getAndSetImage(news: [Articles],
                                cell: NewsTableViewCell,
                                indexPath: IndexPath) {
        
        DispatchQueue.global().async {
            
            guard let imageUrl = URL(string: news[indexPath.row].urlToImage!) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            guard let image = UIImage(data: imageData) else { return }
            
            DispatchQueue.main.async {
                cell.imageNews.image = image
            }
        }
    }
}
