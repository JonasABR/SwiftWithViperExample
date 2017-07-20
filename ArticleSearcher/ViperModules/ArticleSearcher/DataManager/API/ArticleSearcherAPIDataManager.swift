//
// Created by Jonas Simões
// Copyright (c) 2017 Jonas. All rights reserved.
//

import Foundation

class ArticleSearcherAPIDataManager: ArticleSearcherAPIDataManagerInputProtocol, ArticleServiceProtocol {
    var apiManager: ArticleServiceProtocol?
    
    init() {
        self.apiManager = Services()
    }
    
    func getArticle(with keyword: String, completion: @escaping ArticleServiceProtocol.CompletionBlock){
        self.apiManager?.getArticle(with: keyword) { (objects: [Doc]?, error: Error?) in
            if objects != nil{
                completion(objects, nil)
            } else{
                completion(nil,error)
            }
            
        }
    
    }
}
