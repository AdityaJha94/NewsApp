//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Aditya Jha on 06/01/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import Foundation
import RxSwift

class NewsListViewModel{
    
    //MARK:- RXSwift Variables
    var observableNews: Variable<News> = Variable(News())
    var errMsgObserver = Variable<String>("")

    
    //MARK:- Get News List
    func getNewsList(){
        let newsDataManager = NewsDataManager(apiClient: NewsAPIClient())
        
        newsDataManager.getNewsList { (result) in
            switch result {
            case .success(let items):
                //print("\(self) retrive news: \(items)")
                self.observableNews.value = items
            case .failure(let error):
               // print("\(self) retrive error: \(error)")
                self.errMsgObserver.value = error.localizedDescription
            }
        }
    }
    
}
