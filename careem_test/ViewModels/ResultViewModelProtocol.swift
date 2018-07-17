//
//  ResultViewModelProtocol.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation
import PromiseKit

/// Protocol represents result view model.
protocol ResultViewModelProtocol {
    
    associatedtype ModelType
    associatedtype QueryType
    
    /// Represents offset in data source
    var pagination: PaginationModel { get }
    
    /// Data source
    var searchMovies: [ModelType] { get }
    
    /// Progress state
    var isLoading: Bool { get }
    
    /// Current query for requests
    var queryModel: QueryType? { get set }
    
    /// Method asks for next chunk of data
    ///
    /// - Parameter queryModel: query for request
    /// - Returns: promise with a suggestion to update UI
    func searchForNextPage(_ queryModel: QueryType) -> Promise<Bool>
}
