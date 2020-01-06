//
//  NewsListTableViewCell.swift
//  NewsApp
//
//  Created by Aditya Jha on 06/01/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import UIKit
import SDWebImage

class NewsListTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsAuthorName: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Load Data
    func setAllValues(article: Articles){
        if let title = article.title{
            newsTitle.text = title
        }
        
        if let author = article.author{
            newsAuthorName.text = "Author: \(author)"
        }else{
            newsAuthorName.text = "Author: NA"
        }
        
        if let requestedDateString = article.publishedAt{
         let requiredTimeDifferenceString = NewsUtil.getTimeDifference(passedDateString: requestedDateString, passedDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
            newsDate.text = requiredTimeDifferenceString
        }
        
        if let urlNewsImage = article.urlToImage{
            newsImage.sd_setImage(with: URL(string: urlNewsImage), placeholderImage: UIImage(named: "transparent-layer"), options: .refreshCached)
        }else{
            newsImage.image = UIImage(named: "transparent")
        }
    }
    
}
