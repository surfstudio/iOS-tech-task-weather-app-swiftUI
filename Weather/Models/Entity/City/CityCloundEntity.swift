//
//  CityCloundEntity.swift
//  WeatherDebug
//

import NodeKit

struct CityCloundEntity {
    /// Облачность в процентах.
    let cloudiness: Int
}

extension CityCloundEntity: DTODecodable {
    static func from(dto: CityCloundEntry) throws -> CityCloundEntity {
        .init(cloudiness: dto.all)
    }
}
