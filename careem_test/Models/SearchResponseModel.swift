//
//  SearchResponseModel.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import ObjectMapper

struct SearchResponseModel: Mappable {

    private(set) var pagination = PaginationModel.initial
    private(set) var movies = [MovieModel]()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        if let page = PaginationModel(map: map) {
            pagination = page
        }
        movies <- map["results"]
    }
}
