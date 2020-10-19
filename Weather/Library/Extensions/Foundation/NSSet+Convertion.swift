//
//  NSSet+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation

extension Array {

    var nsSet: NSSet {
        NSSet(array: self)
    }
}
