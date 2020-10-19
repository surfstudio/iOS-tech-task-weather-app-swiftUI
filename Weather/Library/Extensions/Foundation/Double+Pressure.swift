//
//  Double+Pressure.swift
//  Weather
//

import Foundation

extension Double {
    var pressure: String {
        if self == .zero {
            return String(format: "%.0f", self)
        } else {
            return String(format: "%.2f", self).replacingOccurrences(of: ".", with: ",")
        }
    }
}
