//
//  DBManagerProtocol.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation

/// Protocol description for a storable entity
protocol Storable {
}

/// Protocol description for database API
protocol DBManagerProtocol {
    
    associatedtype T: Storable
    associatedtype F: Storable, NSFastEnumeration
    
    /// Write given object to persistent storage
    ///
    /// - Parameter obj: object to write
    func store(_ obj: T)
    
    /// Delete an object for specific type by key
    ///
    /// - Parameters:
    ///   - type: type of object to delete
    ///   - key: primary key
    func delete(_ type: T.Type, key: String)
    
    /// Read data from persistent storage
    ///
    /// - Parameters:
    ///   - type: type of data
    ///   - filter: predicate for filtering
    ///   - sortKey: sort data by key
    ///   - ascending: sort direction
    ///   - prefix: return first N objects
    /// - Returns: List of found objects
    func get(_ type: T.Type, filter: String?, sortKey: String?, ascending: Bool, prefix: Int?) -> F
}
