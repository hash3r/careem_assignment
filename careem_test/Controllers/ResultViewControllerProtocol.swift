//
//  ResultViewControllerProtocol.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import Foundation

protocol ResultViewControllerProtocol: class {
    
    var queryModel: SearchQueryModel? { get set }
    var delegate: ResultViewControllerDelegate? { get set }
    
    func loadData(initial: Bool)
}

protocol ResultViewControllerDelegate: class {
    
    func didLoadMovies(_ controller: ResultViewControllerProtocol)
    func didFailToLoadMovies(_ controller: ResultViewControllerProtocol, error: Error)
}
