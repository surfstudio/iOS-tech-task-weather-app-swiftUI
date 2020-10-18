//
//  CacheDetailedWeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 18.10.2020.
//
//

import Foundation
import CoreData

extension CacheDetailedWeatherEntity {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CacheDetailedWeatherEntity> {
        return NSFetchRequest<CacheDetailedWeatherEntity>(entityName: "CacheDetailedWeatherEntity")
    }

    @NSManaged public var daily: NSSet?
    @NSManaged public var hourly: NSSet?
    @NSManaged public var monutely: NSSet?

}

// MARK: Generated accessors for daily
extension CacheDetailedWeatherEntity {

    @objc(addDailyObject:)
    @NSManaged public func addToDaily(_ value: CacheDetailedDailyWeatherEntity)

    @objc(removeDailyObject:)
    @NSManaged public func removeFromDaily(_ value: CacheDetailedDailyWeatherEntity)

    @objc(addDaily:)
    @NSManaged public func addToDaily(_ values: NSSet)

    @objc(removeDaily:)
    @NSManaged public func removeFromDaily(_ values: NSSet)

}

// MARK: Generated accessors for hourly
extension CacheDetailedWeatherEntity {

    @objc(addHourlyObject:)
    @NSManaged public func addToHourly(_ value: CacheDetailedHourlyWeatherEntity)

    @objc(removeHourlyObject:)
    @NSManaged public func removeFromHourly(_ value: CacheDetailedHourlyWeatherEntity)

    @objc(addHourly:)
    @NSManaged public func addToHourly(_ values: NSSet)

    @objc(removeHourly:)
    @NSManaged public func removeFromHourly(_ values: NSSet)

}

// MARK: Generated accessors for monutely
extension CacheDetailedWeatherEntity {

    @objc(addMonutelyObject:)
    @NSManaged public func addToMonutely(_ value: CacheDetailedMinutelyWeatherEntity)

    @objc(removeMonutelyObject:)
    @NSManaged public func removeFromMonutely(_ value: CacheDetailedMinutelyWeatherEntity)

    @objc(addMonutely:)
    @NSManaged public func addToMonutely(_ values: NSSet)

    @objc(removeMonutely:)
    @NSManaged public func removeFromMonutely(_ values: NSSet)

}
