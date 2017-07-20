//
// Created by Jonas Simões
// Copyright (c) 2017 Jonas. All rights reserved.
//

import Foundation
import UIKit

class ArticleSearcherView: UIViewController, ArticleSearcherViewProtocol {
    var presenter: ArticleSearcherPresenterProtocol?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    @IBOutlet var alertView: UIView!
    
    var articles: [Doc]?
    
    let cellIdentifier = "ArticleTableViewCell"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Article Searcher"
        self.setupTableView()
        self.setupAlertView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.alertView != nil{
            UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseIn, animations: {
                self.alertView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            }) { (finished) in
                if(finished){
                    self.alertView.removeFromSuperview()
                }
            }
        }
    }
    
    //MARK: - Helpers
    private func setupAlertView(){
        if self.alertView != nil{
            self.alertView.layer.cornerRadius = 8
            self.alertView.layer.masksToBounds = true
        }
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle.main),
                                forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150.0
    }
    
    func showLoadingView(){
        self.loadingView.startAnimating()
    }
    
    func hideLoadingView(){
        self.loadingView.stopAnimating()
    }
    
    //MARK: - Actions
    @IBAction func searchButton(_ sender: Any) {
        guard let searchTerm = searchTextField.text, searchTextField.text != "" else {
            return
        }
        self.presenter?.getArticle(with: searchTerm, requestType: .online, completion: { (objects, error) in
            self.articles = objects
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)

        })
    }
    
    func pushToReaderViewController(_ doc: Doc){
        if let newsViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReaderViewController") as? ReaderViewController{
            newsViewController.articleUrl = doc.webUrl
            self.navigationController?.pushViewController(newsViewController, animated: true)
        }
    }
}

//MARK: Extension
extension ArticleSearcherView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! ArticleTableViewCell
        cell.dataSource = self.articles?[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ArticleSearcherView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let doc = self.articles?[indexPath.row]{
            self.pushToReaderViewController(doc)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rateAction = UITableViewRowAction(style: .normal, title: "Save") { (action , indexPath ) -> Void in
            guard let article = self.articles?[indexPath.row] else{
                return
            }
            UserDefaults.standard.saveArticle(doc: article)
            self.tableView.setEditing(false, animated: true)
        }
        return [rateAction]
    }
}

extension ArticleSearcherView: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.searchButton(self)
        return true
    }
}

extension ArticleSearcherView: ArticleCellDelegate{
    func saveArticle(doc: Doc){
        UserDefaults.standard.saveArticle(doc: doc)
        self.tableView.setEditing(false, animated: true)
    }
}
