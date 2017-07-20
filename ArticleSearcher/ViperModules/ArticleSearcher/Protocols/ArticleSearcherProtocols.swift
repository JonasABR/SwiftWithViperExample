//
// Created by Jonas Simões
// Copyright (c) 2017 Jonas. All rights reserved.
//

import Foundation
import UIKit

protocol ArticleSearcherViewProtocol: class {
    var presenter: ArticleSearcherPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol ArticleSearcherWireframeProtocol: class {
    static func presentArticleSearcherModule(fromView view: UIViewController)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol ArticleSearcherPresenterProtocol:  class {
    var view: ArticleSearcherViewProtocol? { get set }
    var interactor: ArticleSearcherInteractorInputProtocol? { get set }
    var wireFrame: ArticleSearcherWireframeProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getArticle(with keyword: String, requestType: RequestType, completion: @escaping ArticleServiceProtocol.CompletionBlock)
    
}

protocol ArticleSearcherInteractorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol ArticleSearcherInteractorInputProtocol: class {
    var presenter: ArticleSearcherInteractorOutputProtocol? { get set }
    var APIDataManager: ArticleServiceProtocol? { get set }
    var localDatamanager: ArticleServiceProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func getArticle(with keyword: String, requestType: RequestType, completion: @escaping ArticleServiceProtocol.CompletionBlock)
}

protocol ArticleSearcherAPIDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol ArticleSearcherLocalDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
