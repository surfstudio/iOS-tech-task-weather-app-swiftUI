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
              rain: self.rain?.doubleValue,
              weather: self.weather?
                .compactMap { $0 as? CacheWeatherCondtionsEntity }
                .map { $0.toEntity() },
              snow: self.snow?.doubleValue,
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
        model.rain = self.rain?.nsNumber
        model.weather = self.weather?.map { $0.toCache(context: context) }.nsSet
        model.snow = self.snow?.nsNumber
        model.pop = self.pop?.nsNumber
        model.windSpeed = self.windSpeed?.nsNumber
        model.visibility = self.visibility?.nsNumber

        return model
    }
}
