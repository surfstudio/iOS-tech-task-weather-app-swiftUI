//
//  CacheDetailedTemperatureEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData


extension CacheDetailedTemperatureEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheDetailedTemperatureEntity> {
        return NSFetchRequest<CacheDetailedTemperatureEntity>(entityName: "CacheDetailedTemperatureEntity")
    }

    @NSManaged public var morning: Double
    @NSManaged public var night: Double
    @NSManaged public var evening: Double
    @NSManaged public var day: Double
    @NSManaged public var min: Double
    @NSManaged public var max: Double
    @NSManaged public var dailyWeather: CacheDetailedDailyWeatherEntity?
    @NSManaged public var dailyWeatherFeelsLike: CacheDetailedDailyWeatherEntity?

}
