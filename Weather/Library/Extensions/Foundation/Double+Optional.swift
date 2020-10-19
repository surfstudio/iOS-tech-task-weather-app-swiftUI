//
//  Double+Optional.swift
//  Weather
//
//  Created by Александр Кравченков on 19.10.2020.
//

import Foundation

extension Optional where Wrapped == Double {
    static func + (lhs: Double?, rhs: Double?) -> Double? {
        guard let lhs = lhs else {
            return rhs
        }

        guard let rhs = rhs else {
            return lhs
        }

        return rhs + lhs
    }
}
