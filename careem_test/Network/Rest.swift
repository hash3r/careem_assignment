//
//  Rest.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON
import HTTPStatusCodes
import PromiseKit


/// REST singleton class for communicating with the services
open class Rest {
    
    /// A shared instance of `RestAPI`, used by top-level request methods
    static let shared = Rest()
    
    /// Alamofire manager  that responsible for creating and managing `Request` objects
    fileprivate let manager = SessionManager()
    
    /// Method requests for data and serializes it to a given model type
    ///
    /// - Parameter target: endpoint to get data
    /// - Returns: promise with a given model type
    func mappableRequest<T: BaseMappable>(_ target: TargetType) -> Promise<T> {
        
        return Promise<T> { seal in
            let router = Router(target)
            let request = manager.request(router)
//            debugPrint(request)
            request.responseObject { (response: DataResponse<T>) -> Void in
//                debugPrint(response.fullDescription)
                if let value = response.result.value, response.isSuccess() {
                    seal.fulfill(value)
                } else {
                    if let error = response.result.error {
                        seal.reject(error)
                    } else {
                        seal.reject(self.defaultRestErrorWith(response.response?.statusCode))
                    }
                }
            }
        }
    }
    
    /// Method requests for data and serializes it to an array of given model type
    ///
    /// - Parameter target: endpoint to get data
    /// - Returns: promise with an array of given model type
    func arrayMappableRequest<T: BaseMappable>(_ target: TargetType) -> Promise<[T]> {
        
        return Promise<[T]> { seal in
            let router = Router(target)
            let request = manager.request(router)
//            debugPrint(request)
            request.responseArray { (response: DataResponse<[T]>) -> Void in
//                debugPrint(response.fullDescription)
                if let value = response.result.value, response.isSuccess() {
                    seal.fulfill(value)
                } else {
                    if let error = response.result.error {
                        seal.reject(error)
                    } else {
                        seal.reject(self.defaultRestErrorWith(response.response?.statusCode))
                    }
                }
            }
        }
    }
    
    fileprivate func defaultRestErrorWith(_ code: Int?) -> NSError {
        return NSError(domain: Bundle.main.bundleIdentifier!, code: code ?? 0, userInfo: [NSLocalizedDescriptionKey: "See response above"])
    }
}
