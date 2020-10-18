//
//  CityRainEntity.swift
//  WeatherDebug
//

import NodeKit

struct PrecipitationEntity {
    /// Объем осадков (дождь), выпавших за последний час.
    /// В миллиметрах.
    let lastOneHour: Double?
    /// Объем осадков (дождь), выпавших за последние 3 часа.
    /// В миллиметрах.
    let lastThreeHours: Double?
}

extension PrecipitationEntity: DTODecodable {
    static func from(dto: PrecipitationEntry) throws -> PrecipitationEntity {
        .init(lastOneHour: dto.h1, lastThreeHours: dto.h3)
    }
}
