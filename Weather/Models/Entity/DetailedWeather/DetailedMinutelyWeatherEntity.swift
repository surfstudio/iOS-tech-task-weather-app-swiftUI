//
//  DetailedMinutelyWeatherEntity.swift
//  Weather
//

import NodeKit

struct DetailedMinutelyWeatherEntity {
    let forecastDate: Date
    /// Осадки в миллиметрах
    let precipitation: Double
}

extension DetailedMinutelyWeatherEntity: DTODecodable {
    static func from(dto: DetailedMinutelyWeatherEntry) throws -> DetailedMinutelyWeatherEntity {
        .init(forecastDate: Date(timeIntervalSince1970: dto.dt),
              precipitation: dto.precipitation)
    }
}
