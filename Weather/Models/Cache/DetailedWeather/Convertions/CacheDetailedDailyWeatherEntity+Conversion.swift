//
//  CacheDetailedDailyWeatherEntity+Conversion.swift
//

import Foundation
import CoreData

extension CacheDetailedDailyWeatherEntity {
    func toEntity() -> DetailedDailyWeatherEntity {
        .init(forecastDate: self.forecastDate,
              temperature: self.temperature?.toEntity(),
              sunrise: self.sunrise,
              sunset: self.sunset,
              feelsLike: self.feelsLike?.toEntity(),
              pressure: self.pressure?.doubleValue,
              humidity: self.humidity?.doubleValue,
              dewPoint: self.dewPoint?.doubleValue,
              clouds: self.clouds?.intValue,
              rain: self.rain?.toEntity(),
              weather: self.weather?.toEntity(),
              snow: self.snow?.toEntity(),
              pop: self.pop?.doubleValue,
              windSpeed: self.windSpeed?.doubleValue,
              visibility: self.visibility?.doubleValue)
    }
}

extension DetailedDailyWeatherEntity {
    func toCache(context: NSManagedObjectContext) -> CacheDetailedDailyWeatherEntity {
        let model = CacheDetailedDailyWeatherEntity(context: context)
        model.forecastDate = self.forecastDate
        model.temperature = self.temperature?.toCache(context: context)
        model.sunrise = self.sunrise
        model.sunset = self.sunset
        model.feelsLike = self.feelsLike?.toCache(context: context)
        model.pressure = self.pressure?.nsNumber
        model.humidity = self.humidity?.nsNumber
        model.dewPoint = self.dewPoint?.nsNumber
        model.clouds = self.clouds?.nsNumber
        model.rain = self.rain?.toCache(context: context)
        model.weather = self.weather?.toCache(context: context)
        model.snow = self.snow?.toCache(context: context)
        model.pop = self.pop?.nsNumber
        model.windSpeed = self.windSpeed?.nsNumber
        model.visibility = self.visibility?.nsNumber

        return model
    }
}
