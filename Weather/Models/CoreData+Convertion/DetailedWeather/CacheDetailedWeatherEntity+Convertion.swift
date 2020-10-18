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

        model.daily = self.daily?.map { $0.toCache(context: context) }.nsSet
        model.hourly = self.hourly?.map { $0.toCache(context: context) }.nsSet
        model.monutely = self.minutely?.map { $0.toCache(context: context) }.nsSet

        return model
    }
}
