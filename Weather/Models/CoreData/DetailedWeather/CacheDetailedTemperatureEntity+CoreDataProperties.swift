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

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CacheDetailedTemperatureEntity> {
        return NSFetchRequest<CacheDetailedTemperatureEntity>(entityName: "CacheDetailedTemperatureEntity")
    }

    @NSManaged public var morning: NSNumber?
    @NSManaged public var night: NSNumber?
    @NSManaged public var evening: NSNumber?
    @NSManaged public var day: NSNumber?
    @NSManaged public var min: NSNumber?
    @NSManaged public var max: NSNumber?
    @NSManaged public var dailyWeather: CacheDetailedDailyWeatherEntity?
    @NSManaged public var dailyWeatherFeelsLike: CacheDetailedDailyWeatherEntity?

}
