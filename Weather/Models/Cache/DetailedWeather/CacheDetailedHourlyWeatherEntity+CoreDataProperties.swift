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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheDetailedHourlyWeatherEntity> {
        return NSFetchRequest<CacheDetailedHourlyWeatherEntity>(entityName: "CacheDetailedHourlyWeatherEntity")
    }

    @NSManaged public var forecastDate: Date?
    @NSManaged public var temperature: Double
    @NSManaged public var feelsLike: Double
    @NSManaged public var pressure: Double
    @NSManaged public var humidity: Double
    @NSManaged public var dewPoint: Double
    @NSManaged public var clouds: Int32
    @NSManaged public var pop: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var visibility: Double
    @NSManaged public var rain: CachePrecipitationEntity?
    @NSManaged public var weather: CacheWeatherCondtionsEntity?
    @NSManaged public var snow: CachePrecipitationEntity?
    @NSManaged public var detailedWeather: CacheDetailedWeatherEntity?

}
