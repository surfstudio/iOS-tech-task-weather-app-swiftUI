//
//  DetailedDailyWeatherEntry.swift
//  Weather
//

import NodeKit

struct DetailedDailyWeatherEntry: Codable {
    let dt: Double
    let temp: DetailedTemperatureEntry
    let sunrise: Double
    let sunset: Double
    let feels_like: DetailedTemperatureEntry
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let clouds: Int
    let rain: PrecipitationEntry
    let weather: WeatherConditionsEntry
    let snow: PrecipitationEntry
    let pop: Double
    let wind_speed: Double
    let visibility: Double
}

extension DetailedDailyWeatherEntry: RawMappable {
    typealias Raw = Json
}
