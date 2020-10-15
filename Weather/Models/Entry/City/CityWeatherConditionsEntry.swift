//
//  CityWeatherConditionsEntry.swift
//  WeatherDebug
//

import NodeKit

struct CityWeatherConditionsEntry: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

extension CityWeatherConditionsEntry: RawMappable {
    typealias Raw = Json
}
