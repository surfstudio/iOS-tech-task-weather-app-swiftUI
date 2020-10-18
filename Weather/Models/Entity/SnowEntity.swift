//
//  CitySnowEntity.swift
//  WeatherDebug
//

import NodeKit

struct SnowEntity {
    /// Объем снега, выпавшего за последний час.
    /// В миллиметрах.
    let lastOneHour: Double?
    /// Объем снега, выпавшего за последние 3 часа.
    /// В миллиметрах.
    let lastThreeHours: Double?
}

extension SnowEntity: DTODecodable {
    static func from(dto: SnowEntry) throws -> SnowEntity {
        .init(lastOneHour: dto.h1, lastThreeHours: dto.h3)
    }
}
