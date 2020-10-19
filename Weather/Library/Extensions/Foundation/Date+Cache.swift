//
//  Date+Cache.swift
//  Weather
//
//  Created by Александр Кравченков on 17.10.2020.
//

import Foundation

extension Date {
    /// Расчитывает, является ли дата "протухшей" относительно заданного промежутка времени
    ///
    /// - Parameters:
    ///     - ttl: Промежуток времени, который
    func isExpired(ttl: TimeInterval) -> Bool {
        // получаем разницу между конкретным временем (self) и временем "сейчас"
        let diff = Date().timeIntervalSince1970 - self.timeIntervalSince1970
        // если разница меньше чем ttl, значит,
        // что точка в которой self будет считаться "протухшим" дальше чем "сейчас"
        return diff > ttl
    }
}
