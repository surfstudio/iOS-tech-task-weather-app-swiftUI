//
//  DateFormatter.swift
//  Weather
//

import Foundation

extension DateFormatter {

    // MARK: - Constants

    private enum Constants {
        static let defaultLocale = Locale(identifier: "RU_ru")
    }

    enum DateFormatterStyle {
        /// HH:mm
        case hoursAndMinutes
        /// EEEE
        case dayName
    }

    // MARK: - Public Methods

    /// Возвращает DateFormatter с определенным форматом даты
    static func with(style: DateFormatterStyle) -> DateFormatter {
        let formatter = DateFormatter()
        switch style {
        case .hoursAndMinutes:
            formatter.dateFormat = "HH:mm"
        case .dayName:
            formatter.dateFormat = "EEEE"
        }
        formatter.locale = Constants.defaultLocale
        return formatter
    }
}
