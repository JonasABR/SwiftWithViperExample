//
//  HTTPClientProtocols.swift
//  ArticleSearcher
//
//  Created by Jonas on 7/18/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import Foundation

//struct HTTPTarget<R: HTTPResource>: HTTPTargetProtocol {
//    let baseURL: URL
//    let resource: R
//}
//
//extension HTTPTargetProtocol {
//    var URL: Foundation.URL {
//        return baseURL.appendingPathComponent(resource.path)
//    }
//}

// MARK: - Protocols


public protocol HTTPResource {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public typealias Parameters = [String: Any]


//public protocol HTTPTargetProtocol {
//    associatedtype Resource: HTTPResource
//    var baseURL: Foundation.URL { get }
//    var resource: Resource { get }
//}
//
//// MARK: Extensions
//
//public extension HTTPClient {
//    private func request<T: HTTPTargetProtocol>(_ target: T) -> Observable<Any?> {
//        return manager.request(url: target.URL,
//                               method: target.resource.method,
//                               params: target.resource.parameters,
//                               useCache: target.resource.useCache)
//    }
//
//    func request<R: HTTPResource>(_ resource: R) -> Observable<Any?> {
//        let target = HTTPTarget(baseURL: baseURL, resource: resource)
//        return request(target)
//    }
//
//}

public extension HTTPResource {
    var method: HTTPMethod {
        return .get
    }

    var parameters: Parameters? {
        return nil
    }

    var useCache: Bool {
        return true
    }
}
