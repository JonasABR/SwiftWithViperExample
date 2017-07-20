//
// Created by Jonas Simões
// Copyright (c) 2017 Jonas. All rights reserved.
//

import Foundation

class ArticleSearcherInteractor: ArticleSearcherInteractorInputProtocol {
    weak var presenter: ArticleSearcherInteractorOutputProtocol?
    var APIDataManager: ArticleServiceProtocol?
    var localDatamanager: ArticleServiceProtocol?
    
    init() {}
    func getArticle(with keyword: String, requestType: RequestType, completion: @escaping ArticleServiceProtocol.CompletionBlock) {
        if(requestType == .online){
            self.APIDataManager?.getArticle(with: keyword, completion: { (objects, error) in
                completion(objects, error)
            })
        } else{
            self.localDatamanager?.getArticle(with: keyword, completion: { (objects, error) in
                completion(objects, error)
            })
        }
    }
}
