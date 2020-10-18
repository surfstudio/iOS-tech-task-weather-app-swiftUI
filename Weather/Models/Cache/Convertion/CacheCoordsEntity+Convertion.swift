//
//  CacheCoordsEntity+Convertion.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import CoreData

extension CacheCoordsEntity {
    func toEntity() -> CoordEntity {
        .init(lon: self.lon, lat: self.lat)
    }
}

extension CoordEntity {
    func toCache(context: NSManagedObjectContext) -> CacheCoordsEntity {
        let model = CacheCoordsEntity(context: context)

        model.lat = self.lat
        model.lon = self.lon

        return model
    }
}
