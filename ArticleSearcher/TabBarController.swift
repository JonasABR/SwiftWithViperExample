//
//  ReaderViewController.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.viewControllers = [self.homeFactory(),
                                self.reviewsFactory()]
        self.tabBar.items?.forEach({ (tabBarItem) in
            tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 20)
        })
    }

    func homeFactory() -> UINavigationController {
        let articleSearch = ArticleSearcherWireframe.configureViewController()
        let homeNavController = UINavigationController(rootViewController: articleSearch)
        homeNavController.tabBarItem = UITabBarItem.init(tabBarSystemItem: .search, tag: 0)
        return homeNavController
    }

    func reviewsFactory() -> UINavigationController {
        let saved = SavedArticleWireframe.configureViewController()
        let homeNavController = UINavigationController(rootViewController: saved)
        homeNavController.tabBarItem = UITabBarItem.init(tabBarSystemItem: .featured ,tag: 1)
        return homeNavController
    }
}
