//
//  CacheDetailedHourlyWeatherEntity+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import CoreData

extension CacheDetailedHourlyWeatherEntity {

    func toEntity() -> DetailedHourlyWeatherEntity {
        .init(forecastDate: self.forecastDate,
              temperature: self.temperature?.doubleValue,
              feelsLike: self.feelsLike?.doubleValue,
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

extension DetailedHourlyWeatherEntity {
    func toCache(context: NSManagedObjectContext) -> CacheDetailedHourlyWeatherEntity {
        let model = CacheDetailedHourlyWeatherEntity(context: context)

        model.forecastDate = self.forecastDate
        model.temperature = self.temperature?.nsNumber
        model.feelsLike = self.feelsLike?.nsNumber
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
