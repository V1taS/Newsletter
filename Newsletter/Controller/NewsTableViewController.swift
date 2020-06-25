//
//  NewsTableViewController.swift
//  Newsletter
//
//  Created by Виталий Сосин on 19.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicatot: UIActivityIndicatorView!
    
    private var news = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkingManager.shared.alamofireGetNews(from: apiKey) { (listNews) in
            DispatchQueue.main.async {
                self.news = listNews
                self.tableView.reloadData()
            }
        }
        
//        NetworkingManager.shared.fetchNews(form: apiKey) { (listNews) in
//            DispatchQueue.main.async {
//                self.news = listNews
//                self.tableView.reloadData()
//            }
//        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! NewsTableViewCell
        
        setBorderFor(cell)
        setTextFor(cell, news, indexPath)
        setImageFor(cell, news, indexPath)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let currentNews = self.news[indexPath.row]
        let descriptionsVC = segue.destination as! DescriptionsViewController
        descriptionsVC.news = currentNews
    }
    
    // MARK: - Private funcs
    private func setBorderFor(_ cell: NewsTableViewCell) {
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = cell.frame.width / 20
    }
    
    private func setTextFor(_ cell: NewsTableViewCell,
                            _ news: [Articles],
                            _ indexPath: IndexPath) {
        
        let currentNews = news[indexPath.row]
        cell.titleLabel.text = currentNews.title
        cell.contentLabel.text = currentNews.description
    }
    
    private func setImageFor(_ cell: NewsTableViewCell,
                             _ news: [Articles],
                             _ indexPath: IndexPath) {
        
        let currentNews = news[indexPath.row]
        
        if let image = currentNews.urlToImage {
            DispatchQueue.global().async {
                let image = NetworkingManager.shared.getAndSetImage(urlImage: image)
                DispatchQueue.main.async {
                    cell.imageNews.image = image
                }
            }
        }
    }
}
