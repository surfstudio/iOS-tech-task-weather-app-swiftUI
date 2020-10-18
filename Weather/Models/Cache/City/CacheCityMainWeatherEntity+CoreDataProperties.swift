//
//  CacheCityMainWeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData

extension CacheCityMainWeatherEntity {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CacheCityMainWeatherEntity> {
        return NSFetchRequest<CacheCityMainWeatherEntity>(entityName: "CacheCityMainWeatherEntity")
    }

    @NSManaged public var temperature: NSNumber?
    @NSManaged public var feelsLikeTemperature: NSNumber?
    @NSManaged public var minTemperature: NSNumber?
    @NSManaged public var maxTemperature: NSNumber?
    @NSManaged public var pressure: NSNumber?
    @NSManaged public var humidity: NSNumber?
    @NSManaged public var seaLevelPressure: NSNumber?
    @NSManaged public var groundLevelPresuure: NSNumber?
    @NSManaged public var city: CacheCityDetailedWeatherEntity?

}
