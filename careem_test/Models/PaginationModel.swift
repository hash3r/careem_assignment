//
//  PaginationModel.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import ObjectMapper

struct PaginationModel: Mappable {

    /// Number of page of results to be returned.
    private(set) var page: Int = 0
    private(set) var totalPages: Int = 0
    private(set) var totalResults: Int = 0
    
    /// Non-mappable
    static var initial = PaginationModel(page: 1, totalPages: 2)
    
    init?(map: Map) {
        self.mapping(map: map)
    }

    init(page: Int, totalPages: Int) {
        self.page = page
        self.totalPages = totalPages
    }
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        totalPages <- map["total_results"]
        totalResults <- map["total_pages"]
    }

    func isLastPage() -> Bool {
        return totalPages <= page
    }
    
    mutating func incrementPage() {
        page += 1
    }
    
//    public func value() -> [(key: String, value: String)] {
//        return [("page", "\(self.page)"),
//                ("totalPages", "\(self.totalPages)")]
//    }
}
