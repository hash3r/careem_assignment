//
//  ResultViewControllerDelegate.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 7/22/18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation

/// Protocol represents the result controller delegate.
protocol ResultViewControllerDelegate: class {
    
    /// Called in case of successful data loading
    ///
    /// - Parameter controller: the controller notifying about result
    func didLoadData(_ controller: ResultViewControllerProtocol)
    
    /// Called in case of failure
    ///
    /// - Parameters:
    /// - Parameter controller: the controller notifying about result
    ///   - error: reason to fail
    func didFailToLoadData(_ controller: ResultViewControllerProtocol, error: Error)
}
