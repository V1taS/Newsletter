//
//  NewsTableViewController.swift
//  Newsletter
//
//  Created by Виталий Сосин on 19.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let networkManager = NetworkingManager()
    var news: [News]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        networkManager.fetchNews()
        print(news)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        cell.titleLabel.text = "Проверка"

        return cell
    }
}

extension NewsTableViewController: NetworkingManagerDelegate {
    func updateInterface(with news: [News]) {
        self.news = news
    }
}
