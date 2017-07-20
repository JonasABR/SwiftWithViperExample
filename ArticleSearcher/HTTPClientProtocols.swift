//
//  HTTPClientProtocols.swift
//  ArticleSearcher
//
//  Created by Jonas on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import Foundation
// MARK: - Protocols
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public typealias Parameters = [String: Any]

