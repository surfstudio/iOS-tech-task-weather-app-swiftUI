//
//  CacheDetailedWeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData


extension CacheDetailedWeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheDetailedWeatherEntity> {
        return NSFetchRequest<CacheDetailedWeatherEntity>(entityName: "CacheDetailedWeatherEntity")
    }

    @NSManaged public var daily: CacheDetailedDailyWeatherEntity?
    @NSManaged public var hourly: CacheDetailedHourlyWeatherEntity?
    @NSManaged public var monutely: CacheDetailedMinutelyWeatherEntity?

}
