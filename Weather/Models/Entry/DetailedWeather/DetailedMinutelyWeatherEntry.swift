//
//  DetailedWeatherMinutelyForecast.swift
//  Weather
//

import NodeKit

struct DetailedMinutelyWeatherEntry: Codable {
    let dt: Double
    let precipitation: Double
}

extension DetailedMinutelyWeatherEntry: RawMappable {
    typealias Raw = Json
}
