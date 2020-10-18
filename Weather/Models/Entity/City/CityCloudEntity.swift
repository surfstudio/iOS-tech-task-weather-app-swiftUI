//
//  CityCloundEntity.swift
//  WeatherDebug
//

import NodeKit

struct CityCloudEntity {
    /// Облачность в процентах.
    let cloudiness: Int
}

extension CityCloudEntity: DTODecodable {
    static func from(dto: CityCloundEntry) throws -> CityCloudEntity {
        .init(cloudiness: dto.all)
    }
}
