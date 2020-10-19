//
//  CacheWeatherCondtionsEntity+Conversion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import CoreData

extension CacheWeatherCondtionsEntity {
    func toEntity() -> WeatherConditionsEntity {
        .init(id: Int(self.id),
              main: self.main,
              description: self.descriptionInfo,
              type: WeatherType(rawValue: Int(self.type)) ?? .unknown)
    }
}

extension WeatherConditionsEntity {
    func toCache(context: NSManagedObjectContext) -> CacheWeatherCondtionsEntity {
        let model = CacheWeatherCondtionsEntity(context: context)

        model.id = Int32(self.id)
        model.main = self.main
        model.descriptionInfo = self.description

        return model
    }
}
