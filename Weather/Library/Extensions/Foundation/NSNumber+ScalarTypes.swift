//
//  Double+NSNumber.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation

extension Double {
    var nsNumber: NSNumber {
        return NSNumber(value: self)
    }
}

extension Int {
    var nsNumber: NSNumber {
        return NSNumber(value: self)
    }
}
