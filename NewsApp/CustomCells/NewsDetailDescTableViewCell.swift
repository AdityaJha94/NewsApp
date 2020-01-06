//
//  NewsDetailDescTableViewCell.swift
//  NewsApp
//
//  Created by Aditya Jha on 06/01/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import UIKit

class NewsDetailDescTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Load Data
    func setValues(description: String){
        descLbl.text = description
    }

}
