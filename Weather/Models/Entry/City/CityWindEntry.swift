//
//  CityWindEntry.swift
//  WeatherDebug
//

import NodeKit

struct CityWindEntry: Codable {
    let speed: Double
    let deg: Double
    let gust: Double?
}

extension CityWindEntry: RawMappable {
    typealias Raw = Json
}
