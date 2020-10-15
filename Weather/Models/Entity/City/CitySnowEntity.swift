//
//  CitySnowEntity.swift
//  WeatherDebug
//

import NodeKit

struct CitySnowEntity {
    /// Объем снега, выпавшего за последний час.
    /// В миллиметрах.
    let lastOneHour: Double?
    /// Объем снега, выпавшего за последние 3 часа.
    /// В миллиметрах.
    let lastThreeHours: Double?
}

extension CitySnowEntity: DTODecodable {
    static func from(dto: CitySnowEntry) throws -> CitySnowEntity {
        .init(lastOneHour: dto.h1, lastThreeHours: dto.h3)
    }
}
