//
// Created by Jonas Simões
// Copyright (c) 2017 Jonas. All rights reserved.
//

import Foundation
import UIKit

protocol ArticleSearcherViewProtocol: class {
    var presenter: ArticleSearcherPresenterProtocol? { get set }
    func showLoadingView()
    func hideLoadingView()
}

protocol ArticleSearcherWireframeProtocol: class {
    static func presentArticleSearcherModule(fromView view: UIViewController)
}

protocol ArticleSearcherPresenterProtocol:  class {
    var view: ArticleSearcherViewProtocol? { get set }
    var interactor: ArticleSearcherInteractorInputProtocol? { get set }
    var wireFrame: ArticleSearcherWireframeProtocol? { get set }
    func getArticle(with keyword: String, requestType: RequestType, completion: @escaping ArticleServiceProtocol.CompletionBlock)
    
}

protocol ArticleSearcherInteractorOutputProtocol: class {

}

protocol ArticleSearcherInteractorInputProtocol: class {
    var presenter: ArticleSearcherInteractorOutputProtocol? { get set }
    var APIDataManager: ArticleServiceProtocol? { get set }
    var localDatamanager: ArticleServiceProtocol? { get set }
    func getArticle(with keyword: String, requestType: RequestType, completion: @escaping ArticleServiceProtocol.CompletionBlock)
}

protocol ArticleSearcherAPIDataManagerInputProtocol: class {

}

protocol ArticleSearcherLocalDataManagerInputProtocol: class {
}
