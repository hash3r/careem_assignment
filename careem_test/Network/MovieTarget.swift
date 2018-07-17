//
//  MovieTarget.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Alamofire

enum Movie {
    case search(PathType, PathType)
}

extension Movie: TargetType {
    
    func baseUrl() -> PathType {
        return Config.MovieDBServer.BaseUrl + Config.MovieDBServer.ApiVersion
    }
    
    func path() -> PathType {
        switch self {
        case .search(let term, let page):
            return "/search/movie?api_key=\(Config.MovieDBServer.AppKey)&query=\(term)&page=\(page)"
        }
    }
    
    func method() -> Alamofire.HTTPMethod {
        switch self {
        case .search: return .get
        }
    }
}
