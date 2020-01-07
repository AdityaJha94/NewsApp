//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Adi on 1/5/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsListViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var newsListTableView: UITableView!
    
    
    //MARK:- Local Variables
    var newsListVm = NewsListViewModel()
    let disposeBag = DisposeBag()
    var articles = [Articles]()
    var vSpinner : UIView?
    
    
    //MARK:- View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setUpRxObservable()
        setUpNavBar()
        fetchNewsListFromAPI()
        
    }
    
    //MARK:- SetUp Navbar Methods
    func setUpNavBar(){
        let logOutBtn = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(self.logoutClicked))
        logOutBtn.tintColor = UIColor.white
        
        logOutBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 16)!], for:.normal)
        
        self.title = "News List"
        self.navigationItem.setRightBarButton(logOutBtn, animated: false)
    }
    
    
    //MARK:- RxObservable Method
    fileprivate func setUpRxObservable(){
        self.newsListVm.errMsgObserver.asObservable()
            .bind { [weak self] (errorMsg) in
                guard let strongSelf = self else { return }
                
                if errorMsg != "" {
                    //                    DispatchQueue.main.async {
                    //                        strongSelf._view.view.makeToast(errorMsg, duration: 3.0, position: .center)
                    //                        self?._view.resetSwipeEffect()
                    //                    }
                }
        }.disposed(by: disposeBag)
        
        self.newsListVm.observableNews.asObservable()
            .bind { [weak self] news in
                guard let strongSelf = self else { return }
                if let status = news.status?.count, status > 0{
                    self?.removeSpinner()
                }
                
                if let articlesFetched = news.articles{
                    //strongSelf.updateUIBasedOnAPIData()
                    strongSelf.articles = articlesFetched
                    //print("newsList vc**\(strongSelf.articles)")
                    DispatchQueue.main.async {
                        self?.newsListTableView.reloadData()
                    }
                    
                }
                
        }.disposed(by: disposeBag)
    }
    
    //MARK:- Redirect To Login Screen
    func redirectToLoginScreen(){
        let isLoggedInFlag = Data(from: false)
        let status = KeychainService.save(key: "isLoggedInFlag", data: isLoggedInFlag)
        print("status: ", status)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = loginVC
    }
    
    
    //MARK:- Button Actions
    @objc func logoutClicked(_ sender: UIBarButtonItem){
        //Set NewsListViewController as Root ViewController
        
        let confirmationAlert = UIAlertController(title: "Confirmation", message: "Are you sure yo want to logout?", preferredStyle: .alert)
        
        
        confirmationAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        confirmationAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            self.redirectToLoginScreen()
        }))
        
        present(confirmationAlert, animated: true, completion: nil)
    }
    
}

//MARK:- TableView Datasource and Delegate Methods
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell") as! NewsListTableViewCell
        cell.setAllValues(article: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 163.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController
        newsDetailVC?.article = articles[indexPath.row]
        self.navigationController?.pushViewController(newsDetailVC!, animated: false)
    }
    
}

//MARK:- Network Call
extension NewsListViewController{
    func fetchNewsListFromAPI(){
        showSpinner(onView: self.view)
        self.newsListVm.getNewsList()
    }
}


//MARK:- Show/Hide Progress Bar
extension NewsListViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}
