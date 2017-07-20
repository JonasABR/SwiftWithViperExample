//
// Created by Jonas Simões
// Copyright (c) 2017 Jonas. All rights reserved.
//

import Foundation

class ArticleSearcherPresenter: ArticleSearcherPresenterProtocol, ArticleSearcherInteractorOutputProtocol {
    weak var view: ArticleSearcherViewProtocol?
    var interactor: ArticleSearcherInteractorInputProtocol?
    var wireFrame: ArticleSearcherWireframeProtocol?
    
    init() {}
    func viewWillAppearEvent(){
        self.view?.showLoadingView()
        self.interactor?.getArticle(with: "", requestType: .offline, completion: { (objects: [Doc]?, error: Error?) in
            self.view?.hideLoadingView()
            
        })
    }
    
    func getArticle(with keyword: String, requestType: RequestType, completion: @escaping ArticleServiceProtocol.CompletionBlock) {
        self.view?.showLoadingView()
        self.interactor?.getArticle(with: keyword, requestType: requestType, completion: { (objects: [Doc]?, error: Error?) in
            self.view?.hideLoadingView()
            completion(objects,error)
        })
    }
    
}
