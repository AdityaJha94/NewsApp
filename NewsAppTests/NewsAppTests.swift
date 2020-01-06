//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Adi on 1/5/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import XCTest
@testable import NewsApp

class NewsAppTests: XCTestCase {
    private let apiClient: NewsAPIClient = NewsAPIClient()
    private let API_KEY = "4af144f691d544769301686008aa12e7"
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK:- Test API
    func testNewsListAPI(){
        let expectation = self.expectation(description: "testNewsListAPI")
        let resource = Resource(url: URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=\(API_KEY)")!)
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                expectation.fulfill()
            case .failure(let error):
                XCTFail("API request/response failure")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }

}
