//
//  UserDefaultsExtension.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/19/17.
//  Copyright © 2017 jonas. All rights reserved.
//
import Foundation

extension UserDefaults{
    enum Keys{
        static let Articles = "articlesSaved"
    }
    
    func saveArticle(doc: Doc){
        if var savedArticles = UserDefaults.standard.value(forKey: UserDefaults.Keys.Articles) as? [Doc]{
            savedArticles.append(doc)
            UserDefaults.standard.set(savedArticles, forKey: UserDefaults.Keys.Articles)
        } else{
            let encodeData = NSKeyedArchiver.archivedData(withRootObject: doc)
            
            let articles = [encodeData]
            UserDefaults.standard.set(articles, forKey: UserDefaults.Keys.Articles)
        }
    }
}
