//
//  CitySystemInfoEntry.swift
//  WeatherDebug
//

import NodeKit

struct CitySystemInfoEntry: Codable {
    let type: String?
    let id: Int?
    let message: String?
    let country: String?
    let sunrise: Double?
    let sunset: Double?
}

extension CitySystemInfoEntry: RawMappable {
    typealias Raw = Json
}
