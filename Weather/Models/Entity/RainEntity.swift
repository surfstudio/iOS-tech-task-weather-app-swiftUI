//
//  CityRainEntity.swift
//  WeatherDebug
//

import NodeKit

struct RainEntity: Codable {
    /// Объем осадков (дождь), выпавших за последний час.
    /// В миллиметрах.
    let lastOneHour: Double?
    /// Объем осадков (дождь), выпавших за последние 3 часа.
    /// В миллиметрах.
    let lastThreeHours: Double?
}

extension RainEntity: DTODecodable {
    static func from(dto: RainEntry) throws -> RainEntity {
        .init(lastOneHour: dto.h1, lastThreeHours: dto.h3)
    }
}
