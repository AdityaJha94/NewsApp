//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Adi on 1/5/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var newsDetailTableView: UITableView!
    
    //MARK- Local Variables
    var article: Articles!
    
    
    //MARK:- View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        self.newsDetailTableView.rowHeight = UITableView.automaticDimension
        self.newsDetailTableView.estimatedRowHeight = 45.0
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- SetUp navbar Method
    func setUpNavBar(){
        self.title = "News Detail"
        let backButton : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(self.backBarButtonItemClicked))
        
        backButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    //MARK:- Button Action
    @objc func backBarButtonItemClicked(sender: UIBarButtonItem){
        self.navigationController!.popViewController(animated: false)
    }
    
}

//MARK:- Tableview Delegate and Datasource methods
extension NewsDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailImageTableViewCell") as! NewsDetailImageTableViewCell
            cell.setValues(article: article)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailDescTableViewCell") as! NewsDetailDescTableViewCell
            if let desc = article.description, let content = article.content{
                cell.setValues(description: desc + "\n" + content)
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300.0
        }else{
            return UITableView.automaticDimension
        }
        
    }
}
