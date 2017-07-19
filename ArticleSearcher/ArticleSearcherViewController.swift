//
//  ArticleSearcherViewController.swift
//  ArticleSearcher
//
//  Created by Jonas on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import UIKit

class ArticleSearcherViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    let apiManager = APISessionManager()
    var articles: [Doc]?
    fileprivate let cellIdentifier = "articleSnippet"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150.0
        self.navigationItem.title = "Article Searcher"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(_ sender: Any) {
        guard let searchTerm = searchTextField.text, searchTextField.text != "" else {
            return
        }
        self.loadingView.startAnimating()
        apiManager.getArticle(keyword: searchTerm) { (objects: [Doc]?, error: Error?) in
            if objects != nil{
                self.loadingView.stopAnimating()
                self.articles = objects
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openWebView"{
            let vc = segue.destination as! ReaderViewController
            guard let cell = sender as? ArticleTableViewCell else{
                return
            }
            vc.articleUrl = cell.dataSource?.webUrl
        }
    }
}

extension ArticleSearcherViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! ArticleTableViewCell
        cell.dataSource = self.articles?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let rateAction = UITableViewRowAction(style: .normal, title: "Save") { (action , indexPath ) -> Void in
            self.tableView.endEditing(true)
            guard let article = self.articles?[indexPath.row] else{
                return
            }
            UserDefaults.standard.saveArticle(doc: article)
        }
        return [rateAction]

    }
}

