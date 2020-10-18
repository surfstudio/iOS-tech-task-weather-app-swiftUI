//
//  CacheDetailedMinutelyWeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData

extension CacheDetailedMinutelyWeatherEntity {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CacheDetailedMinutelyWeatherEntity> {
        return NSFetchRequest<CacheDetailedMinutelyWeatherEntity>(entityName: "CacheDetailedMinutelyWeatherEntity")
    }

    @NSManaged public var forecastDate: Date
    @NSManaged public var precipitation: Double
    @NSManaged public var detailedWeather: CacheDetailedWeatherEntity?

}
