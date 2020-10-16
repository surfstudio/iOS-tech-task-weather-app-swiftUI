//
//  CacheDetailedDailyWeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData


extension CacheDetailedDailyWeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheDetailedDailyWeatherEntity> {
        return NSFetchRequest<CacheDetailedDailyWeatherEntity>(entityName: "CacheDetailedDailyWeatherEntity")
    }

    @NSManaged public var forecastDate: Date
    @NSManaged public var sunrise: Date?
    @NSManaged public var sunset: Date?
    @NSManaged public var pressure: NSNumber?
    @NSManaged public var humidity: NSNumber?
    @NSManaged public var dewPoint: NSNumber?
    @NSManaged public var clouds: NSNumber?
    @NSManaged public var pop: NSNumber?
    @NSManaged public var windSpeed: NSNumber?
    @NSManaged public var visibility: NSNumber?
    @NSManaged public var temperature: CacheDetailedTemperatureEntity?
    @NSManaged public var feelsLike: CacheDetailedTemperatureEntity?
    @NSManaged public var rain: CachePrecipitationEntity?
    @NSManaged public var snow: CachePrecipitationEntity?
    @NSManaged public var weather: CacheWeatherCondtionsEntity?
    @NSManaged public var detailedWeather: CacheDetailedWeatherEntity?

}
