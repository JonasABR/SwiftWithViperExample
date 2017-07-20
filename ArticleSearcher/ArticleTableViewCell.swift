//
//  ArticleTableViewCell.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import UIKit
import Nuke

protocol ArticleCellDelegate: class {
    func saveArticle(doc: Doc)
}

class ArticleTableViewCell: UITableViewCell {
    fileprivate let nyTimesUrl = "https://www.nytimes.com/"
    @IBOutlet private var articleImageView : UIImageView!
    @IBOutlet private var articleDescription : UILabel!
    @IBOutlet private var likeButton : UIButton!
    weak var delegate: ArticleCellDelegate?

    var dataSource : Doc?{
        didSet{
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.likeButton.setImage(AssetsCatalog.Like, for: .selected)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.articleImageView.image = AssetsCatalog.Placeholder
        self.likeButton.isSelected = false
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
    
    @IBAction func likeButton(_ sender: Any) {
        self.likeButton.isSelected = !self.likeButton.isSelected
        if let doc = dataSource{
            self.delegate?.saveArticle(doc: doc)
        }
    }

}
