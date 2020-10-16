//
//  CacheWeatherCondtionsEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData


extension CacheWeatherCondtionsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheWeatherCondtionsEntity> {
        return NSFetchRequest<CacheWeatherCondtionsEntity>(entityName: "CacheWeatherCondtionsEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var main: String?
    @NSManaged public var descriptionInfo: String?
    @NSManaged public var type: Int32
    @NSManaged public var city: CacheCityDetailedWeatherEntity?
    @NSManaged public var dailyWeather: CacheDetailedDailyWeatherEntity?
    @NSManaged public var hourlyWeather: CacheDetailedHourlyWeatherEntity?

}
