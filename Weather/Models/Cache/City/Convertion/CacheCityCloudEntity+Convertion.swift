//
//  CacheCityCloudEntity+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import CoreData

extension CacheCityCloudEntity {

    func toEntity() -> CityCloudEntity {
        .init(cloudiness: Int(self.cloudiness))
    }
}

extension CityCloudEntity {
    func toCache(context: NSManagedObjectContext) -> CacheCityCloudEntity {
        let model = CacheCityCloudEntity(context: context)
        model.cloudiness = Int32(self.cloudiness)
        return model
    }
}
