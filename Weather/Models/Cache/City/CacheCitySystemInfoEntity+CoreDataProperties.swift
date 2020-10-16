//
//  CacheCitySystemInfoEntity+CoreDataProperties.swift
//  
//
//  Created by Александр Кравченков on 16.10.2020.
//
//

import Foundation
import CoreData

extension CacheCitySystemInfoEntity {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CacheCitySystemInfoEntity> {
        return NSFetchRequest<CacheCitySystemInfoEntity>(entityName: "CacheCitySystemInfoEntity")
    }

    @NSManaged public var type: String?
    @NSManaged public var id: NSNumber?
    @NSManaged public var message: String?
    @NSManaged public var sunrise: Date?
    @NSManaged public var country: String?
    @NSManaged public var sunset: Date?
    @NSManaged public var city: CacheCityDetailedWeatherEntity?

}
