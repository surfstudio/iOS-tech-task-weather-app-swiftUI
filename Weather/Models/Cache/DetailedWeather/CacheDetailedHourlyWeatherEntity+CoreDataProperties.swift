//
//  CacheDetailedHourlyWeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData

extension CacheDetailedHourlyWeatherEntity {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CacheDetailedHourlyWeatherEntity> {
        return NSFetchRequest<CacheDetailedHourlyWeatherEntity>(entityName: "CacheDetailedHourlyWeatherEntity")
    }

    @NSManaged public var forecastDate: Date?
    @NSManaged public var temperature: NSNumber?
    @NSManaged public var feelsLike: NSNumber?
    @NSManaged public var pressure: NSNumber?
    @NSManaged public var humidity: NSNumber?
    @NSManaged public var dewPoint: NSNumber?
    @NSManaged public var clouds: NSNumber?
    @NSManaged public var pop: NSNumber?
    @NSManaged public var windSpeed: NSNumber?
    @NSManaged public var visibility: NSNumber?
    @NSManaged public var rain: CachePrecipitationEntity?
    @NSManaged public var weather: CacheWeatherCondtionsEntity?
    @NSManaged public var snow: CachePrecipitationEntity?
    @NSManaged public var detailedWeather: CacheDetailedWeatherEntity?

}
