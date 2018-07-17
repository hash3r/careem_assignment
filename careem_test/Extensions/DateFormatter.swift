//
//  DateFormatter.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.

import Foundation

class DateFormatter {
    
    static let instance = DateFormatter()

    let movie = Foundation.DateFormatter()

    init() {
        movie.dateFormat = "yyyy-mm-dd"
    }
}
