//
//  CityMainWeatherInfoEntity.swift
//  WeatherDebug
//

import NodeKit

/// Вся температура измеряется в градусах Цельсия
struct CityMainWeatherInfoEntity {
    let temperature: Double?
    let feelsLikeTemperature: Double?
    let minTemperature: Double?
    let maxTemperature: Double?
    /// Атмосферное давление (над уровнем моря, если нет `seaLevelPressure` и `groundLevelPresuure`) в гектопаскалях
    let pressure: Double?
    /// Влажность воздуха в процентах.
    let humidity: Int?
    /// Атмосфреное давление над уровнем моря в гектопаскалях
    let seaLevelPressure: Double?
    /// Атмосферное давление над уровнем земли в гектопаскалях
    let groundLevelPresuure: Double?
}

extension CityMainWeatherInfoEntity: DTODecodable {
    static func from(dto: CityMainWeatherInfoEntry) throws -> CityMainWeatherInfoEntity {
        .init(temperature: dto.temp,
              feelsLikeTemperature: dto.feels_like,
              minTemperature: dto.temp_min,
              maxTemperature: dto.temp_max,
              pressure: dto.pressure,
              humidity: dto.humidity,
              seaLevelPressure: dto.sea_level,
              groundLevelPresuure: dto.grnd_level)
    }
}
