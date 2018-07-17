//
//  ResultViewModelProtocol.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation
import PromiseKit

protocol ResultViewModelProtocol {
    associatedtype ModelType
    associatedtype QueryType
    
    var pagination: PaginationModel { get }
    var searchMovies: [ModelType] { get }
    var isLoading: Bool { get }
    var queryModel: QueryType? { get set }
    
    func searchForNextPage(_ queryModel: QueryType) -> Promise<Bool>
}
