//
//  CacheDetailedTemperatureEntity+Conversion.swift
//
//  Created by Александр Кравченков on 16.10.2020.
//

import CoreData

extension CacheDetailedTemperatureEntity {

    func toEntity() -> DetailedTemperatureEntity {
        .init(morning: self.morning?.doubleValue,
              day: self.day?.doubleValue,
              evening: self.evening?.doubleValue,
              night: self.night?.doubleValue,
              min: self.min?.doubleValue,
              max: self.max?.doubleValue)
    }
}

extension DetailedTemperatureEntity {
    func toCache(context: NSManagedObjectContext) -> CacheDetailedTemperatureEntity {
        let model = CacheDetailedTemperatureEntity(context: context)
        model.morning = self.morning?.nsNumber
        model.day = self.day?.nsNumber
        model.evening = self.evening?.nsNumber
        model.night = self.night?.nsNumber
        model.min = self.min?.nsNumber
        model.max = self.max?.nsNumber

        return model
    }
}
