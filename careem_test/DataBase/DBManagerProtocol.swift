//
//  DBManagerProtocol.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation

protocol Storable {

}

//Protocol description for database API
protocol DBManagerProtocol {
    
    associatedtype T: Storable
    associatedtype F: Storable, NSFastEnumeration
    
    func store(_ obj: T)
    func delete(_ type: T.Type, key: String)
    func get(_ type: T.Type, filter: String?, sortKey: String?, ascending: Bool, prefix: Int?) -> F
}
