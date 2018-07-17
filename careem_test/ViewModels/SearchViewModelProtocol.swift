//
//  SearchViewModelProtocol.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

protocol SearchViewModelProtocol {
    
    associatedtype QueryType: RealmCollectionValue
    
    /// container for all possible parameters in query
    var queryModel: QueryType { get }
    /// recent queries models & strings
    var suggestions: List<QueryType> { get }
    var suggestionsStrings: [String] { get }
    
    /// update current query
    func updateQuery(_ term: String)
    /// write query to local storage
    func storeQuery(query: QueryType)
}
