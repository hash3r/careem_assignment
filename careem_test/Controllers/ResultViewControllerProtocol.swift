//
//  ResultViewControllerProtocol.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation

/// Protocol represents the result controller object.
protocol ResultViewControllerProtocol: class {
    
    /// Container for all parameters in query
    var queryModel: SearchQueryModel? { get set }
    
    /// Delegate for callbacks
    var delegate: ResultViewControllerDelegate? { get set }
    
    /// Method for loading data sequentially
    ///
    /// - Parameter initial: whether is first call or not
    func loadData(initial: Bool)
}

/// Protocol represents the result controller delegate.
protocol ResultViewControllerDelegate: class {
    
    /// Called in case of successful data loading
    ///
    /// - Parameter controller: the controller notifying about result
    func didLoadMovies(_ controller: ResultViewControllerProtocol)
    
    /// Called in case of failure
    ///
    /// - Parameters:
    /// - Parameter controller: the controller notifying about result
    ///   - error: reason to fail
    func didFailToLoadMovies(_ controller: ResultViewControllerProtocol, error: Error)
}
