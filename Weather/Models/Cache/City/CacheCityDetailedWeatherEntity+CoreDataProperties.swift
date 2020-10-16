//
//  CacheCityDetailedWeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData


extension CacheCityDetailedWeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheCityDetailedWeatherEntity> {
        return NSFetchRequest<CacheCityDetailedWeatherEntity>(entityName: "CacheCityDetailedWeatherEntity")
    }

    @NSManaged public var base: String?
    @NSManaged public var time: Date?
    @NSManaged public var timezone: Int32
    @NSManaged public var cityId: String?
    @NSManaged public var cityName: String?
    @NSManaged public var cod: String?
    @NSManaged public var coords: CacheCoordsEntity?
    @NSManaged public var weather: NSSet?
    @NSManaged public var main: CacheCityMainWeatherEntity?
    @NSManaged public var wind: CacheWindEntity?
    @NSManaged public var clouds: CacheCityCloudEntity?
    @NSManaged public var rain: CachePrecipitationEntity?
    @NSManaged public var snow: CachePrecipitationEntity?
    @NSManaged public var systemInfo: CacheCitySystemInfoEntity?

}

// MARK: Generated accessors for weather
extension CacheCityDetailedWeatherEntity {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: CacheWeatherCondtionsEntity)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: CacheWeatherCondtionsEntity)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}
