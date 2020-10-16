//
//  CacheCityCloudEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData

extension CacheCityCloudEntity {

    @nonobjc public
    class func fetchRequest() -> NSFetchRequest<CacheCityCloudEntity> {
        return NSFetchRequest<CacheCityCloudEntity>(entityName: "CacheCityCloudEntity")
    }

    @NSManaged public var cloudiness: Int32
    @NSManaged public var city: CacheCityDetailedWeatherEntity?

}
