//
//  Date+Init.swift
//  WeatherDebug
//

import Foundation

extension Date {
    /// Позволяет инициаллизировать дату опциональным занчением Unix-timestamp-ом
    /// Если значение nil - врнет nil
    /// Иначе вызовет Data(timeIntervalSince1970:)
    init?(unixTimestamp: Double?) {
        guard let timestamp = unixTimestamp else {
            return nil
        }
        self.init(timeIntervalSince1970: timestamp)
    }
}
