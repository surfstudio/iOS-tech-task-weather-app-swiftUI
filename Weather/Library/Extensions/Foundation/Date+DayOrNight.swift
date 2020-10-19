//
//  Date+DayOrNight.swift
//  Weather
//

import Foundation

extension Date {
    /// Определяет день или ночь
    var isDay: Bool {
        guard
            let hour = Calendar.current.dateComponents([.hour], from: self).hour
        else {
            return false
        }

        return hour > 6 && hour < 22
    }
}
