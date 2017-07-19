//
//  UIImageViewExtension.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    
    func setImage(url: URL?, placeholder: UIImage? = nil) {
        if placeholder != nil {
            self.image = placeholder
        }
        guard let url = url else {
            return
        }
        Nuke.loadImage(with: url, into: self)
    }
    
    func setImage<P: Processing>(url: URL?, placeholder: UIImage? = nil, processing: P?) {
        if placeholder != nil {
            self.image = placeholder
        }
        guard let url = url else {
            return
        }
        var request: Request
        if let processing = processing {
            request = Request(url: url).processed(with: processing)
        } else {
            request = Request(url: url)
        }
        Nuke.loadImage(with: request, into: self)
    }

}
