//
//  CitySystemInfoEntry.swift
//  WeatherDebug
//

import NodeKit

struct CitySystemInfoEntity: Codable {
    let type: String?
    let id: Int?
    let message: String?
    let country: String?
    let sunrise: Date?
    let sunset: Date?
}

extension CitySystemInfoEntity: DTODecodable {
    static func from(dto: CitySystemInfoEntry) throws -> CitySystemInfoEntity {
        .init(type: dto.type,
              id: dto.id,
              message: dto.message,
              country: dto.country,
              sunrise: Date(unixTimestamp: dto.sunrise),
              sunset: Date(unixTimestamp: dto.sunset))
    }
}
