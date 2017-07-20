//
//  SavedArticleViewController.swift
//  ArticleSearcher
//
//  Created by Jonas on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import UIKit

class SavedArticleView: ArticleSearcherView {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getArticle(with: "", requestType: .offline, completion: { (objects, error) in
            self.articles = objects
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rateAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action , indexPath ) -> Void in
            UserDefaults.standard.removeArticle(index: indexPath.row)
            self.articles?.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        return [rateAction]
    }


}

