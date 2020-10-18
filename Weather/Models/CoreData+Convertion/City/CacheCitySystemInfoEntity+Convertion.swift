//
//  CacheCitySystemInfoEntity+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import CoreData

extension CacheCitySystemInfoEntity {

    func toEntity() -> CitySystemInfoEntity {
        .init(type: self.type,
              id: self.id?.intValue,
              message: self.message,
              country: self.country,
              sunrise: self.sunrise,
              sunset: self.sunset)
    }
}

extension CitySystemInfoEntity {
    func toCache(context: NSManagedObjectContext) -> CacheCitySystemInfoEntity {
        let model = CacheCitySystemInfoEntity(context: context)
        model.type = self.type
        model.id = self.id?.nsNumber
        model.message = self.message
        model.country = self.country
        model.sunrise = self.sunrise
        model.sunset = self.sunset

        return model
    }
}
