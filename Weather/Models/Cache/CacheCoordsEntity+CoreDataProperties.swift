//
//  CacheCoordsEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData

extension CacheCoordsEntity {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CacheCoordsEntity> {
        return NSFetchRequest<CacheCoordsEntity>(entityName: "CacheCoordsEntity")
    }

    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
    @NSManaged public var city: CacheCityDetailedWeatherEntity?

}
