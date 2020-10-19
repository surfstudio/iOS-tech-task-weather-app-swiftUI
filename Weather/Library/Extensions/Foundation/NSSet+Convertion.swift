//
//  NSSet+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation

extension NSSet {
    func toEntity<T>() -> [T] {
        return self.compactMap { $0 as? T }
    }
}

extension Array {
    var nsSet: NSSet {
        NSSet(array: self)
    }
}
