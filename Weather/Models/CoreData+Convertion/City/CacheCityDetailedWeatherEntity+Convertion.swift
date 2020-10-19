//
//  CacheCityDetailedWeatherEntity+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import CoreData

extension CacheCityDetailedWeatherEntity {

    func toEntity() -> CityDetailedEntity {
        .init(coords: self.coords.toEntity(),
              weather: self.weather?.compactMap { $0 as? WeatherConditionsEntity } ?? [],
              base: self.base,
              main: self.main?.toEntity(),
              wind: self.wind?.toEntity(),
              clouds: self.clouds?.toEntity(),
              rain: self.rain?.toEntity(),
              snow: self.snow?.toEntity(),
              time: self.time,
              systemInfo: self.systemInfo?.toEntity(),
              timezone: self.timezone?.intValue,
              cityId: Int(self.cityId),
              cityName: self.cityName)
    }
}

extension CityDetailedEntity {
    func toCache(context: NSManagedObjectContext) -> CacheCityDetailedWeatherEntity {
        let model = CacheCityDetailedWeatherEntity(context: context)
        model.coords = self.coords.toCache(context: context)
        let weathers = self.weather?.map { $0.toCache(context: context) }
        model.weather = NSSet(array: weathers ?? [])
        model.base = self.base
        model.main = self.main?.toCache(context: context)
        model.wind = self.wind?.toCache(context: context)
        model.clouds = self.clouds?.toCache(context: context)
        model.rain = self.rain?.toCache(context: context)
        model.snow = self.snow?.toCache(context: context)
        model.time = self.time
        model.systemInfo = self.systemInfo?.toCache(context: context)
        model.timezone = self.timezone?.nsNumber
        model.cityId = Int32(self.cityId)
        model.cityName = self.cityName
        return model
    }
}
