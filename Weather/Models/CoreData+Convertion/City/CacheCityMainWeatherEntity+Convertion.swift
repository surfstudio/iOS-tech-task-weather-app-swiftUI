//
//  CacheCityMainWeatherEntity+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import CoreData

extension CacheCityMainWeatherEntity {

    func toEntity() -> CityMainWeatherInfoEntity {
        .init(temperature: self.temperature?.doubleValue,
              feelsLikeTemperature: self.feelsLikeTemperature?.doubleValue,
              minTemperature: self.minTemperature?.doubleValue,
              maxTemperature: self.maxTemperature?.doubleValue,
              pressure: self.pressure?.doubleValue,
              humidity: self.humidity?.intValue,
              seaLevelPressure: self.seaLevelPressure?.doubleValue,
              groundLevelPresuure: self.groundLevelPresuure?.doubleValue)
    }
}

extension CityMainWeatherInfoEntity {
    func toCache(context: NSManagedObjectContext) -> CacheCityMainWeatherEntity {
        let model = CacheCityMainWeatherEntity(context: context)
        model.temperature = self.temperature?.nsNumber
        model.feelsLikeTemperature = self.feelsLikeTemperature?.nsNumber
        model.minTemperature = self.minTemperature?.nsNumber
        model.maxTemperature = self.maxTemperature?.nsNumber
        model.pressure = self.pressure?.nsNumber
        model.humidity = self.humidity?.nsNumber
        model.seaLevelPressure = self.seaLevelPressure?.nsNumber
        model.groundLevelPresuure = self.groundLevelPresuure?.nsNumber

        return model
    }
}
