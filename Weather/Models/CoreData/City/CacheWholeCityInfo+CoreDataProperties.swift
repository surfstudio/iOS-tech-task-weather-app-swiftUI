//
//  CacheWholeCityInfo+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 17.10.2020.
//
//

import Foundation
import CoreData

extension CacheWholeCityInfo {

    @nonobjc
    public
    class func fetchRequest() -> NSFetchRequest<CacheWholeCityInfo> {
        return NSFetchRequest<CacheWholeCityInfo>(entityName: "CacheWholeCityInfo")
    }

    @NSManaged public var createdAt: Date
    @NSManaged public var city: CacheCityDetailedWeatherEntity

}
