//
// Created by Jonas Simões
// Copyright (c) 2017 Jonas. All rights reserved.
//

import Foundation

class ArticleSearcherLocalDataManager: ArticleSearcherLocalDataManagerInputProtocol, ArticleServiceProtocol {
    var apiManager: ArticleServiceProtocol?
    
    init() {
        self.apiManager = OffflineSessionManager()
    }
    
    func getArticle(with keyword: String, completion: @escaping ArticleServiceProtocol.CompletionBlock){
        guard let objects = UserDefaults.standard.getArticlesSaved() else {
            completion(nil,nil)
            return
        }
        completion(objects, nil)
    }

}
