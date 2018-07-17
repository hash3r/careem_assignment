//
//  SearchQueryModel.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation
import RealmSwift
import Realm


class SearchQueryModel: Object {

    @objc dynamic private(set) var term: String = ""
    @objc dynamic private(set) var date = Date()

    override static func primaryKey() -> String? {
        return #keyPath(term)
    }
    
    convenience init(term: String) {
        self.init()
        self.term = term
        self.date = Date()
    }
}
