//
//  DetailedTemperature.swift
//  Weather
//

import NodeKit

struct DetailedTemperatureEntry: Codable {
    let morn: Double?
    let day: Double?
    let eve: Double?
    let night: Double?
    let min: Double?
    let max: Double?
}

extension DetailedTemperatureEntry: RawMappable {
    typealias Raw = Json
}
