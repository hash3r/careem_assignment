//
//  Config.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation

struct Config {
    
    struct MovieDBServer {
        static let BaseUrl = "http://api.themoviedb.org"
        static let ApiVersion = "/3"
        static let AppKey = "2696829a81b1b5827d515ff121700838"
    }
    
    struct PostersServer {
        static let BaseUrl = "http://image.tmdb.org/t/p"
    }
}
