//
//  CacheDetailedMinutelyWeatherEntity+Cenvertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import CoreData

extension CacheDetailedMinutelyWeatherEntity {

    func toEntity() -> DetailedMinutelyWeatherEntity {
        .init(forecastDate: self.forecastDate,
              precipitation: self.precipitation)
    }
}

extension DetailedMinutelyWeatherEntity {
    func toCache(context: NSManagedObjectContext) -> CacheDetailedMinutelyWeatherEntity {
        let model = CacheDetailedMinutelyWeatherEntity(context: context)
        model.forecastDate = self.forecastDate
        model.precipitation = self.precipitation

        return model
    }
}
