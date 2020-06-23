//
//  DescriptionsViewController.swift
//  Newsletter
//
//  Created by Виталий Сосин on 24.06.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class DescriptionsViewController: UIViewController {
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var descriptionsTextView: UITextView!
    
    var news: Articles!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionsTextView.text = news?.description
        setImageFor(news: news, to: imageNews)
        title = news.title
    }
    
    // MARK: - Private funcs
    private func setImageFor(news from: Articles, to: UIImageView) {
        
        if let image = from.urlToImage {
            DispatchQueue.global().async {
                let image = NetworkingManager.shared.getAndSetImage(urlImage: image)
                DispatchQueue.main.async {
                    to.image = image
                }
            }
        }
    }
}
