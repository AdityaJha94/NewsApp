//
//  NewsDetailImageTableViewCell.swift
//  NewsApp
//
//  Created by Aditya Jha on 06/01/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import UIKit

class NewsDetailImageTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var newsTitleLbl: UILabel!
    @IBOutlet weak var newsAuthorLbl: UILabel!
    @IBOutlet weak var newsTimeLbl: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addGradient()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK:- Load Data
    func setValues(article: Articles){
        if let title = article.title{
            newsTitleLbl.text = title
        }
        
        if let author = article.author{
            newsAuthorLbl.text = "Author: \(author)"
        }else{
            newsAuthorLbl.text = "Author: NA"
        }
        
        if let requestedDateString = article.publishedAt{
        let requiredTimeDifferenceString = NewsUtil.getTimeDifference(passedDateString: requestedDateString, passedDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
            newsTimeLbl.text = requiredTimeDifferenceString
        }
        
        if let urlNewsImage = article.urlToImage{
            newsImage.sd_setImage(with: URL(string: urlNewsImage), placeholderImage: UIImage(named: "transparent-layer"), options: .refreshCached)
        }else{
            newsImage.image = UIImage(named: "transparent")
        }
        
    }
    
    //MARK:- Add Gradient Method
    func addGradient(){
        let gradient = CAGradientLayer()
        
        gradient.frame = newsImage.frame
        
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        
        gradient.locations = [0.0, 1.0]
        
        newsImage.layer.insertSublayer(gradient, at: 0)
    }
    
}
