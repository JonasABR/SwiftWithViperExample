//
//  Docs.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import UIKit
import Unbox

struct Doc {
    let docId: String
    let webUrl: String
    let snippet: String
    let multimedia: [Multimedia]?
    let pubDate: String
    let documentType: String
}

extension Doc{
    class Helper: NSObject, NSCoding {
        
        var doc: Doc?
        init(doc: Doc) {
            super.init()
            self.doc = doc
        }
        //MARK: - NSCoding
        required init?(coder aDecoder: NSCoder) {
            super.init()
            let docId = aDecoder.decodeObject(forKey: "docId") as! String
            let webUrl = aDecoder.decodeObject(forKey: "webUrl") as! String
            let snippet = aDecoder.decodeObject(forKey: "snippet") as! String
            let multimedia = aDecoder.decodeObject(forKey: "multimedia") as! [Multimedia]
            let pubDate = aDecoder.decodeObject(forKey: "pubDate") as!String
            let documentType = aDecoder.decodeObject(forKey: "documentType") as! String
            doc = Doc(docId: docId, webUrl: webUrl, snippet: snippet, multimedia: multimedia, pubDate: pubDate, documentType: documentType)
        }
        
        func encode(with aCoder: NSCoder) {
            aCoder.encode(doc!.docId, forKey: "docId")
            aCoder.encode(doc!.webUrl, forKey: "webUrl")
            aCoder.encode(doc!.snippet, forKey: "snippet")
            aCoder.encode(doc!.multimedia, forKey: "multimedia")
            aCoder.encode(doc!.pubDate, forKey: "pubDate")
            aCoder.encode(doc!.documentType, forKey: "documentType")
        }
    }
}


extension Doc: Unboxable{
    init(unboxer: Unboxer) throws {
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
    let width: Int
    let url: String
    let height: Int
    let type: String
    
    init(width: Int, url: String, height: Int, type: String) {
        self.width = width
        self.url = url
        self.height = height
        self.type = type
    }
    
    init?(coder aDecoder: NSCoder) {
        self.width = aDecoder.decodeObject(forKey: "width") as! Int
        self.url = aDecoder.decodeObject(forKey: "url") as! String
        self.height = aDecoder.decodeObject(forKey: "height") as! Int
        self.type = aDecoder.decodeObject(forKey: "type") as! String

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.width, forKey: "width")
        aCoder.encode(self.url, forKey: "documentType")
        aCoder.encode(self.height, forKey: "documentType")
        aCoder.encode(self.type, forKey: "documentType")

    }
    
    required init(unboxer: Unboxer) throws {
        self.width = try unboxer.unbox(key: "width")
        self.url = try unboxer.unbox(key: "url")
        self.height = try unboxer.unbox(key: "height")
        self.type = try unboxer.unbox(key: "type")
    }

}
