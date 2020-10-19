//
//  CityDetailedWeatherEntry.swift
//  WeatherDebug
//

import NodeKit

struct CityDetailedWeatherEntry: Codable {
    let coord: CoordEntry
    let weather: [WeatherConditionsEntry]?
    let base: String?
    let main: CityMainWeatherInfoEntry?
    let wind: CityWindEntry?
    let clouds: CityCloundEntry?
    let rain: PrecipitationEntry?
    let snow: PrecipitationEntry?
    let dt: Double?
    let sys: CitySystemInfoEntry?
    let timezone: Int?
    let id: Int
    let name: String?
}

extension CityDetailedWeatherEntry: RawMappable {
    typealias Raw = Json
}
