//
//  DetailedTemperatureEntшен.swift
//  Weather
//

import NodeKit

struct DetailedTemperatureEntity {
    let morning: Double?
    let day: Double?
    let evening: Double?
    let night: Double?
    let min: Double?
    let max: Double?
}

extension DetailedTemperatureEntity: DTODecodable {
    static func from(dto: DetailedTemperatureEntry) throws -> DetailedTemperatureEntity {
        .init(morning: dto.morn,
              day: dto.day,
              evening: dto.eve,
              night: dto.night,
              min: dto.min,
              max: dto.max)
    }
}
