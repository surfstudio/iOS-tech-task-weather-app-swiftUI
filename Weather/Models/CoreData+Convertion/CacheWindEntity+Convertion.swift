//
//  CacheWindEntity+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import CoreData

extension CacheWindEntity {
    func toEntity() -> WindEntity {
        .init(speed: self.speed,
              direction: WindDirection(degrees: self.direction?.doubleValue ?? -1),
              gust: self.gust?.doubleValue)
    }
}

extension WindEntity {
    func toCache(context: NSManagedObjectContext) -> CacheWindEntity {
        let model = CacheWindEntity(context: context)

        model.speed = self.speed
        model.direction = self.direction?.rawValue.nsNumber
        model.gust = self.gust?.nsNumber

        return model
    }
}
