//
//  CityDetailedWeatherEntry.swift
//  WeatherDebug
//

import NodeKit

struct CityDetailedWeatherEntry: Codable {
    let coord: CoordEntry
    let weather: [WeatherConditionsEntry]
    let base: String
    let main: CityMainWeatherInfoEntry
    let wind: CityWindEntry
    let clouds: CityCloundEntry
    let rain: RainEntry
    let snow: SnowEntry
    let dt: Double
    let sys: CitySystemInfoEntry
    let timezone: Int
    let id: String
    let name: String
    let cod: String
}

extension CityDetailedWeatherEntry: RawMappable {
    typealias Raw = Json
}
