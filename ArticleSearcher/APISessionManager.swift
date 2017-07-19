//
//  APISessionManager.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//


import Foundation
import Unbox

protocol ArticleServiceProtocol {
    typealias CompletionBlock = (_ objects: [Doc]?, _ error: Error?) -> Swift.Void
    func getArticle(keyword: String, completion: @escaping CompletionBlock)
}


final class APISessionManager {
    fileprivate let urlNYArticleSearch = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
    fileprivate let apiKey = "e515593b026c49a680d4c918c4723481"
    
    fileprivate func request(_ url: String , method: HTTPMethod, params : Parameters?, completion: @escaping(_ successCallback: [String: Any]?, _ error: Error?)-> Swift.Void){
        
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: url + "?api-key=\(apiKey)")!)
        if method == .post, let paramsObj = params{
            do{
                let data:Data = try JSONSerialization.data(withJSONObject: paramsObj, options: [])
                request.httpBody = data
            } catch{}
        
        } else if method == .get, let paramsString = params?.stringFromHttpParameters(){
            request = URLRequest(url: URL(string: (request.url?.absoluteString)! + "&\(paramsString)")!)
        }
        request.httpMethod = method.rawValue
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if let data = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        guard let jsonDic = json as? [String: Any], error == nil else{
                            completion(nil, error)
                            return
                        }
                        completion(jsonDic, nil)
                    } catch let error{
                        completion(nil, error)
                    }
                } else if let error = error{
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}

extension APISessionManager : ArticleServiceProtocol{
    func getArticle(keyword: String, completion: @escaping ArticleServiceProtocol.CompletionBlock) {
        let params: Parameters = ["q" : keyword]
        self.request(self.urlNYArticleSearch, method: .get, params: params) { (response: [String : Any]?, error: Error?) in
            if let response = response?["response"] as? [String: Any], let docs = response["docs"] as? [[String: Any]]{
                let returnValue: [Doc] = docs.flatMap({try? unbox(dictionary: $0)})
                    completion(returnValue, nil)
            } else{
                completion(nil,error)
            }
        }
    }
}
