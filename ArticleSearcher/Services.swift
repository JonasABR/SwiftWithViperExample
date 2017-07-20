//
//  Services.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/20/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import Foundation
import Unbox

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public typealias Parameters = [String: Any]

protocol ArticleServiceProtocol: class {
    typealias CompletionBlock = (_ objects: [Doc]?, _ error: Error?) -> Swift.Void
    func getArticle(with keyword: String, completion: @escaping CompletionBlock)
}

class Services {
    fileprivate let urlNYArticleSearch = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
    let sessionManager = APISessionManager()
}

extension Services : ArticleServiceProtocol{
    func getArticle(with keyword: String, completion: @escaping ArticleServiceProtocol.CompletionBlock) {
        let params: Parameters = ["q" : keyword]
        sessionManager.request(self.urlNYArticleSearch, method: .get, params: params) { (response: [String : Any]?, error: Error?) in
            if let response = response?["response"] as? [String: Any], let docs = response["docs"] as? [[String: Any]]{
                let returnValue: [Doc] = docs.flatMap({try? unbox(dictionary: $0)})
                completion(returnValue, nil)
            } else{
                completion(nil,error)
            }
        }
    }
}
