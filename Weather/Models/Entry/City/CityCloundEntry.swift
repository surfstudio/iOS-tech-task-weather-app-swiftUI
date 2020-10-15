//
//  CityCloundEntry.swift
//  WeatherDebug
//

import NodeKit

struct CityCloundEntry: Codable {
    let all: Int
}

extension CityCloundEntry: RawMappable {
    typealias Raw = Json
}
