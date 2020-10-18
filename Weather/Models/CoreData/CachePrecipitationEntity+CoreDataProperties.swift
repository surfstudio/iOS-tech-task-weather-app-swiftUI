//
//  CachePrecipitationEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 18.10.2020.
//
//

import Foundation
import CoreData

extension CachePrecipitationEntity {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CachePrecipitationEntity> {
        return NSFetchRequest<CachePrecipitationEntity>(entityName: "CachePrecipitationEntity")
    }

    @NSManaged public var lastOneHour: NSNumber?
    @NSManaged public var lastThreeHours: NSNumber?
    @NSManaged public var city: CacheCityDetailedWeatherEntity?
    @NSManaged public var hourlyWeatherRain: CacheDetailedHourlyWeatherEntity?
    @NSManaged public var hourlyWeatherSnow: CacheDetailedHourlyWeatherEntity?
    @NSManaged public var snow: CacheCityDetailedWeatherEntity?

}
