//
//  Double+Precipitation.swift
//  Weather
//

import Foundation

extension Double {
    var precipitation: String {
        if self == .zero {
            return String(format: "%.0f", self)
        } else {
            return String(format: "%.1f", self).replacingOccurrences(of: ".", with: ",")
        }
    }
}
