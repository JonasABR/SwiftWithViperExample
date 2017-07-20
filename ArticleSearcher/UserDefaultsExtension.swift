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
    
    func performSave(objects : [Doc]){
        let encodeData = NSKeyedArchiver.archivedData(withRootObject: objects)
        UserDefaults.standard.set(encodeData, forKey: UserDefaults.Keys.Articles)
        UserDefaults.standard.synchronize()

    }
    func saveArticle(doc: Doc){
        var objects = [Doc]()
        if let saved = getArticlesSaved(){
            objects = saved
        }
        objects.append(doc)
        self.performSave(objects: objects)
    }
    
    func removeArticle(index: Int){
        if var saved = getArticlesSaved(){
            saved.remove(at: index)
            self.performSave(objects: saved)
        }
    }
    
    func getArticlesSaved() -> [Doc]?{
        if let savedArticlesData = UserDefaults.standard.value(forKey: UserDefaults.Keys.Articles) as? Data{
            if let archivedObj = NSKeyedUnarchiver.unarchiveObject(with: savedArticlesData) as? [Doc]{
                return archivedObj
            }
        }
        return nil
    }
}
