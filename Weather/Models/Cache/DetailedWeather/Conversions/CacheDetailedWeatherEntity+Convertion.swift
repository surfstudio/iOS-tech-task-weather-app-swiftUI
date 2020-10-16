//
//  CacheDetailedWeatherEntity+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import CoreData

extension CacheDetailedWeatherEntity {

    func toEntity() -> DetailedWeatherEntity {
        .init(daily: self.daily?.toEntity(),
              hourly: self.hourly?.toEntity(),
              minutely: self.monutely?.toEntity())
    }
}

extension DetailedWeatherEntity {
    func toCache(context: NSManagedObjectContext) -> CacheDetailedWeatherEntity {
        let model = CacheDetailedWeatherEntity(context: context)

        model.daily = self.daily?.toCache(context: context)
        model.hourly = self.hourly?.toCache(context: context)
        model.monutely = self.minutely?.toCache(context: context)

        return model
    }
}
