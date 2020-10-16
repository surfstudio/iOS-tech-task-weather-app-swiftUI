//
//  DetailedHourlyWeatherEntity.swift
//  Weather
//

import NodeKit

/// Вся температура в градусах Цельсия
struct DetailedHourlyWeatherEntity {
    let forecastDate: Date?
    let temperature: Double?
    let feelsLike: Double?
    let pressure: Double?
    let humidity: Double?
    let dewPoint: Double?
    let clouds: Int?
    let rain: PrecipitationEntity?
    let weather: WeatherConditionsEntity?
    let snow: PrecipitationEntity?
    let pop: Double?
    let windSpeed: Double?
    let visibility: Double?
}

extension DetailedHourlyWeatherEntity: DTODecodable {

    static func from(dto: DetailedHourlyWeatherEntry) throws -> DetailedHourlyWeatherEntity {
        .init(forecastDate: Date(unixTimestamp: dto.dt),
              temperature: dto.temp,
              feelsLike: dto.feels_like,
              pressure: dto.pressure,
              humidity: dto.humidity,
              dewPoint: dto.dew_point,
              clouds: dto.clouds,
              rain: try .from(dto: dto.rain),
              weather: try .from(dto: dto.weather),
              snow: try .from(dto: dto.snow),
              pop: dto.pop,
              windSpeed: dto.wind_speed,
              visibility: dto.visibility)
    }
}
