//
//  OffflineSessionManager.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/19/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import Foundation

class OffflineSessionManager:  ArticleServiceProtocol{
    func getArticle(with keyword: String, completion: @escaping CompletionBlock){
        guard let objects = UserDefaults.standard.getArticlesSaved() else {
            completion(nil,nil)
            return
        }
        completion(objects, nil)
    }
}
