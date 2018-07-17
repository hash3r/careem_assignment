//
//  Router.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Alamofire
import SwiftyJSON
import ObjectMapper

/// Router helps to manage requests to specific target
public struct Router {

    private let target: TargetType

    private func url() -> URL {
        let fullUrl = target.baseUrl() + target.path()
        return URL(string: fullUrl.encodeURLQuery())!
    }
    
    private func headers() -> HTTPHeaders {
        let headers = HTTPHeaders()
        //        headers["Content-Type"] = "application/json"
        return headers
    }
    
    init(_ target: TargetType) {
        self.target = target
    }
}

// MARK: URLRequestConvertible
extension Router: URLRequestConvertible {

    public func asURLRequest() -> URLRequest {
        var request = try! URLRequest(url: url(), method: target.method(), headers: headers())
        request.httpMethod = target.method().rawValue
        
        if let params = target.params() {
            let data = try? JSON(params).rawData()
            request.httpBody = data
        }
        return request
    }
}
