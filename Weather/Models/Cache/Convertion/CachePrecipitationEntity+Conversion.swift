//
//  CachePrecipitationEntity+Conversion.swift
//
//  Created by Александр Кравченков on 16.10.2020.
//

import CoreData

extension CachePrecipitationEntity {
    func toEntity() -> PrecipitationEntity {
        .init(lastOneHour: self.lastOneHour?.doubleValue,
              lastThreeHours: self.lastThreeHours?.doubleValue)
    }
}

extension PrecipitationEntity {
    func toCache(context: NSManagedObjectContext) -> CachePrecipitationEntity {
        let model = CachePrecipitationEntity(context: context)
        model.lastOneHour = self.lastOneHour?.nsNumber
        model.lastThreeHours = self.lastThreeHours?.nsNumber

        return model
    }
}
