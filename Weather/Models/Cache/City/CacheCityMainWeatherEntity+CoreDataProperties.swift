//
//  CacheCityMainWeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData


extension CacheCityMainWeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheCityMainWeatherEntity> {
        return NSFetchRequest<CacheCityMainWeatherEntity>(entityName: "CacheCityMainWeatherEntity")
    }

    @NSManaged public var temperature: Double
    @NSManaged public var feelsLikeTemperature: Double
    @NSManaged public var minTemperature: Double
    @NSManaged public var maxTemperature: Double
    @NSManaged public var pressure: Double
    @NSManaged public var humidity: Int32
    @NSManaged public var seaLevelPressure: Double
    @NSManaged public var groundLevelPresuure: Double
    @NSManaged public var city: CacheCityDetailedWeatherEntity?

}
