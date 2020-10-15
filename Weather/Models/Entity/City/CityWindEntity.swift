//
//  CityWindEntity.swift
//  WeatherDebug
//

import NodeKit

struct CityWindEntity {
    /// Скорость ветра в метр/сек
    let speed: Double
    let direction: WindDirection?
    /// Скорость порывов ветра в метр/сек
    let gust: Double?
}

extension CityWindEntity: DTODecodable {
    static func from(dto: CityWindEntry) throws -> CityWindEntity {
        .init(speed: dto.speed,
              direction: WindDirection(degrees: dto.deg),
              gust: dto.gust)
    }
}
