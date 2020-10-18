//
//  DetailedWeatherMeasurement.swift
//  WeatherDebug
//

import NodeKit

struct DetailedHourlyWeatherEntry: Codable {
    let dt: Double
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let clouds: Int
    let rain: RainEntry
    let weather: WeatherConditionsEntry
    let snow: SnowEntry
    let pop: Double
    let wind_speed: Double
    let visibility: Double
}

extension DetailedHourlyWeatherEntry: RawMappable {
    typealias Raw = Json
}
