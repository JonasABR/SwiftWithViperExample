//
//  Docs.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import UIKit
import Unbox

class Doc: NSObject, NSCoding, Unboxable {
    let docId: String
    let webUrl: String
    let snippet: String
    let multimedia: [Multimedia]?
    let pubDate: String
    let documentType: String
    
    init(docId: String, webUrl: String, snippet: String, multimedia: [Multimedia], pubDate: String, documentType: String) {
        self.docId = docId
        self.webUrl = webUrl
        self.snippet = snippet
        self.multimedia = multimedia
        self.pubDate = pubDate
        self.documentType = documentType
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.docId = aDecoder.decodeObject(forKey: "docId") as! String
        self.webUrl = aDecoder.decodeObject(forKey: "webUrl") as! String
        self.snippet = aDecoder.decodeObject(forKey: "snippet") as! String
        self.multimedia = aDecoder.decodeObject(forKey: "multimedia") as? [Multimedia]
        self.pubDate = aDecoder.decodeObject(forKey: "pubDate") as!String
        self.documentType = aDecoder.decodeObject(forKey: "documentType") as! String

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.docId, forKey: "docId")
        aCoder.encode(self.webUrl, forKey: "webUrl")
        aCoder.encode(self.snippet, forKey: "snippet")
        aCoder.encode(self.multimedia, forKey: "multimedia")
        aCoder.encode(self.pubDate, forKey: "pubDate")
        aCoder.encode(self.documentType, forKey: "documentType")
    }

    required init(unboxer: Unboxer) throws {
        self.docId = try unboxer.unbox(key: "_id")
        self.webUrl = try unboxer.unbox(key: "web_url")
        self.snippet = try unboxer.unbox(key: "snippet")
        self.multimedia = try? unboxer.unbox(key: "multimedia")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: try unboxer.unbox(key: "pub_date"))
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertedDate = dateFormatter.string(from: date!)
        if convertedDate != "" {
            self.pubDate = convertedDate
        } else{
            self.pubDate = try unboxer.unbox(key: "pub_date")
        }
        self.documentType = try unboxer.unbox(key: "document_type")
    }
}

final class Multimedia: NSObject, Unboxable, NSCoding{
    let width: Int?
    let url: String?
    let height: Int?
    let type: String?
    
    init(width: Int, url: String, height: Int, type: String) {
        self.width = width
        self.url = url
        self.height = height
        self.type = type
    }
    
    init?(coder aDecoder: NSCoder) {
        self.width = aDecoder.decodeObject(forKey: "width") as? Int
        self.url = aDecoder.decodeObject(forKey: "url") as? String
        self.height = aDecoder.decodeObject(forKey: "height") as? Int
        self.type = aDecoder.decodeObject(forKey: "type") as? String

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.width, forKey: "width")
        aCoder.encode(self.url, forKey: "url")
        aCoder.encode(self.height, forKey: "height")
        aCoder.encode(self.type, forKey: "type")

    }
    
    required init(unboxer: Unboxer) throws {
        self.width = try? unboxer.unbox(key: "width")
        self.url = try? unboxer.unbox(key: "url")
        self.height = try? unboxer.unbox(key: "height")
        self.type = try? unboxer.unbox(key: "type")
    }

}
