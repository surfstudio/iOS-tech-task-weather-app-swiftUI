//
//  CacheDetailedWeatherEntity+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import CoreData

extension CacheDetailedWeatherEntity {

    func toEntity() -> DetailedWeatherEntity {
        .init(daily: self.daily?
                .compactMap { $0 as? CacheDetailedDailyWeatherEntity }
                .map { $0.toEntity() },
              hourly: self.hourly?
                .compactMap { $0 as? CacheDetailedHourlyWeatherEntity }
                .map { $0.toEntity() },
              minutely: self.monutely?
                .compactMap { $0 as? CacheDetailedMinutelyWeatherEntity }
                .map { $0.toEntity() })
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
