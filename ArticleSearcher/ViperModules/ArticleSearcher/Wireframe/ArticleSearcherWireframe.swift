//
// Created by Jonas Simões
// Copyright (c) 2017 Jonas. All rights reserved.
//

import Foundation
import UIKit

class ArticleSearcherWireframe: ArticleSearcherWireframeProtocol {
    class func presentArticleSearcherModule(fromView view: UIViewController) {
        let ArticleSearcherView = ArticleSearcherWireframe.configureViewController()
        view.navigationController?.pushViewController(ArticleSearcherView, animated: true)
    }

    class func configureViewController() -> UIViewController {
        // Generating module components
        let view: ArticleSearcherViewProtocol = ArticleSearcherView()
        let presenter: ArticleSearcherPresenterProtocol & ArticleSearcherInteractorOutputProtocol = ArticleSearcherPresenter()
        let interactor: ArticleSearcherInteractorInputProtocol = ArticleSearcherInteractor()
        let APIDataManager: ArticleSearcherAPIDataManagerInputProtocol & ArticleServiceProtocol = ArticleSearcherAPIDataManager()
        let localDataManager: ArticleSearcherLocalDataManagerInputProtocol & ArticleServiceProtocol = ArticleSearcherLocalDataManager()
        let wireFrame: ArticleSearcherWireframeProtocol = ArticleSearcherWireframe()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager

        return view as! UIViewController
    }
}
