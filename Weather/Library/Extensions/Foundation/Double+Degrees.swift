//
//  Double+Degrees.swift
//  Weather
//

import Foundation

extension Double {
    var degrees: String {
        return String(format: "%.0f°", self)
    }
}
