//
//  Double+Percentage.swift
//  Weather
//

import Foundation

extension Double {
    var percent: String {
        return String(format: "%.0f%%", self * 100)
    }
}
