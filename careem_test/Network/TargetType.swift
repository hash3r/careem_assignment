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

public protocol TargetType {
    
    func baseUrl() -> PathType
    func path() -> PathType
    func method() -> Alamofire.HTTPMethod
    func params() -> ParametersType?
}

extension TargetType {
    //implement default behaviour
    func params() -> ParametersType? {
        return nil
    }
}
