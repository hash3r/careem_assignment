//
//  TargetType.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Alamofire

public typealias PathType = String
public typealias ParametersType = Any // [String: AnyObject]

/// Protocol describes endpoints metadata
public protocol TargetType {
    
    func baseUrl() -> PathType
    func path() -> PathType
    func method() -> Alamofire.HTTPMethod
    func params() -> ParametersType?
}

/// implement default behaviour
extension TargetType {
    
    func params() -> ParametersType? {
        return nil
    }
}
