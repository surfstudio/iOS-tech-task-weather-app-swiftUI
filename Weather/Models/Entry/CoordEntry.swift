//
//  CoordEntry.swift
//  WeatherDebug
//

import NodeKit

struct CoordEntry: Codable {
    let lon: Double
    let lat: Double
}

extension CoordEntry: RawMappable {
    typealias Raw = Json
}
