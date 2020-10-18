//
//  DetailedDailyWeatherEntity.swift
//  Weather
//

import NodeKit

/// Вся температура в градусах цельсия
struct DetailedDailyWeatherEntity {
    let forecastDate: Date
    let temperature: DetailedTemperatureEntity?
    let sunrise: Date?
    let sunset: Date?
    let feelsLike: DetailedTemperatureEntity?
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

extension DetailedDailyWeatherEntity: DTODecodable {
    static func from(dto: DetailedDailyWeatherEntry) throws -> DetailedDailyWeatherEntity {
        .init(forecastDate: Date(timeIntervalSince1970: dto.dt),
              temperature: try .from(dto: dto.temp),
              sunrise: Date(unixTimestamp: dto.sunrise),
              sunset: Date(unixTimestamp: dto.sunset),
              feelsLike: try .from(dto: dto.feels_like),
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
