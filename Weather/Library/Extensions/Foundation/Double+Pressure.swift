//
//  Double+Pressure.swift
//  Weather
//

import Foundation

extension Double {
    var pressure: String {
        return String(format: "%.2f", self).replacingOccurrences(of: ".", with: ",")
    }
}
