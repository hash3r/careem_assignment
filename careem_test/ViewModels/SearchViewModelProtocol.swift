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

/// Protocol represents search view model.
protocol SearchViewModelProtocol {
    
    associatedtype QueryType: RealmCollectionValue
    
    /// Container for all parameters in query
    var queryModel: QueryType { get }
    
    /// Recent queries models & strings
    var suggestions: List<QueryType> { get }
    var suggestionsStrings: [String] { get }
    
    /// Update current query with parameters
    ///
    /// - Parameter term: new search parameter
    func updateQuery(_ term: String)
    
    /// Write query to local storage
    ///
    /// - Parameter query: query to store
    func storeQuery(query: QueryType)
}
