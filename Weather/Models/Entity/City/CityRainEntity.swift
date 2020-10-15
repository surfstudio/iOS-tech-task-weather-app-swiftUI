//
//  CityRainEntity.swift
//  WeatherDebug
//

import NodeKit

struct CityRainEntity: Codable {
    /// Объем осадков (дождь), выпавших за последний час.
    /// В миллиметрах.
    let lastOneHour: Double?
    /// Объем осадков (дождь), выпавших за последние 3 часа.
    /// В миллиметрах.
    let lastThreeHours: Double?
}

extension CityRainEntity: DTODecodable {
    static func from(dto: CityRainEntry) throws -> CityRainEntity {
        .init(lastOneHour: dto.h1, lastThreeHours: dto.h3)
    }
}
