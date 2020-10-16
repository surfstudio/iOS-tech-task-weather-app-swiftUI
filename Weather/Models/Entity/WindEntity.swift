//
//  CityWindEntity.swift
//  WeatherDebug
//

import NodeKit

struct WindEntity {
    /// Скорость ветра в метр/сек
    let speed: Double
    let direction: WindDirection?
    /// Скорость порывов ветра в метр/сек
    let gust: Double?
}

extension WindEntity: DTODecodable {
    static func from(dto: CityWindEntry) throws -> WindEntity {
        .init(speed: dto.speed,
              direction: WindDirection(degrees: dto.deg),
              gust: dto.gust)
    }
}
