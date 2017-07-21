//
//  ArticleTableViewCell.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import UIKit
import Nuke

class ArticleTableViewCell: UITableViewCell {
    fileprivate let nyTimesUrl = "https://www.nytimes.com/"
    @IBOutlet private var articleImageView : UIImageView!
    @IBOutlet private var articleDescription : UILabel!

    var dataSource : Doc?{
        didSet{
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    
    func bindData(){
        if (self.dataSource?.multimedia?.count)! > 0 , let imageUrl = self.dataSource?.multimedia?[0].url{
            self.articleImageView.setImage(url: URL(string: nyTimesUrl + imageUrl), placeholder: AssetsCatalog.Placeholder
            )
        }else{
            self.articleImageView.image = AssetsCatalog.Placeholder
        }
        if let snippet = self.dataSource?.snippet, let date = self.dataSource?.pubDate, let doctype = self.dataSource?.documentType{
            self.articleDescription.text = "\(snippet) \ndate: \(date)\ntype: \(doctype)"
            self.articleDescription.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
}
