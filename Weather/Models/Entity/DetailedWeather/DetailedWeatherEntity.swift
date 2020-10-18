//
//  DetailedWeatherEntity.swift
//  Weather
//

import NodeKit

struct DetailedWeatherEntity {
    let daily: DetailedDailyWeatherEntity?
    let hourly: DetailedHourlyWeatherEntity?
    let minutely: DetailedMinutelyWeatherEntity?
}

extension DetailedWeatherEntity: DTODecodable {
    static func from(dto: DetailedWeatherEntry) throws -> DetailedWeatherEntity {
        .init(daily: try .from(dto: dto.daily),
              hourly: try .from(dto: dto.hourly),
              minutely: try .from(dto: dto.minutely))
    }
}
