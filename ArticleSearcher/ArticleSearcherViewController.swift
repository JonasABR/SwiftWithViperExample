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
    @IBOutlet var alertView: UIView!
    var apiManager: ArticleServiceProtocol?
    var articles: [Doc]?
    fileprivate let cellIdentifier = "ArticleTableViewCell"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Article Searcher"
        self.setupTableView()
        self.setupAlertView()
        self.apiManager = APISessionManager()
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

    //MARK: - Actions
    @IBAction func searchButton(_ sender: Any) {
        guard let searchTerm = searchTextField.text, searchTextField.text != "" else {
            return
        }
        self.loadingView.startAnimating()
        self.apiManager?.getArticle(with: searchTerm) { (objects: [Doc]?, error: Error?) in
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
            guard let indexPath = sender as? IndexPath else{
                return
            }
            vc.articleUrl =  self.articles?[indexPath.row].webUrl
        }
    }
}
//MARK: Extension
extension ArticleSearcherViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! ArticleTableViewCell
        cell.dataSource = self.articles?[indexPath.row]
        return cell
    }
}

extension ArticleSearcherViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.performSegue(withIdentifier: "openWebView", sender: indexPath)
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
