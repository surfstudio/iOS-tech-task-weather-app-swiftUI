//
//  MainCityWeatherInfoEntry.swift
//  WeatherDebug
//

import NodeKit

struct CityMainWeatherInfoEntry: Codable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let humidity: Int?
    let sea_level: Double?
    let grnd_level: Double?
}

extension CityMainWeatherInfoEntry: RawMappable {
    typealias Raw = Json
}
