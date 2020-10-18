//
//  DetailedWeatherEntity.swift
//  Weather
//

import NodeKit

struct DetailedWeatherEntry: Codable {
    let daily: [DetailedDailyWeatherEntry]?
    let hourly: [DetailedHourlyWeatherEntry]?
    let minutely: [DetailedMinutelyWeatherEntry]?
}

extension DetailedWeatherEntry: RawMappable {
    typealias Raw = Json
}
