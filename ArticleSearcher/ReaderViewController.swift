//
//  ReaderViewController.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import UIKit

class ReaderViewController: UIViewController {
    @IBOutlet var webView :UIWebView!
    @IBOutlet var loadingView :UIActivityIndicatorView!
    var articleUrl : String?
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = nil
        if let url = articleUrl{
            self.webView.loadRequest(URLRequest(url: URL(string: url)!))
            self.loadingView.startAnimating()
        }
    }
}
//MARK: Extension
extension ReaderViewController: UIWebViewDelegate{
    func webViewDidFinishLoad(_ webView: UIWebView){
        self.loadingView.stopAnimating()
    }
}
