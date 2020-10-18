//
//  CityWeatherConditionsEntry.swift
//  WeatherDebug
//

import NodeKit

struct WeatherConditionsEntry: Codable {
    let id: Int
    let main: String?
    let description: String?
}

extension WeatherConditionsEntry: RawMappable {
    typealias Raw = Json
}
