//
//  CityDetailedListEntity.swift
//  Weather
//
//  Created by Александр Кравченков on 19.10.2020.
//

import Foundation
import NodeKit

struct CityDetailedListEntity {
    var list: [CityDetailedEntity]
}

extension CityDetailedListEntity: DTODecodable {
    static func from(dto: CityDetailedListEntry) throws -> CityDetailedListEntity {
        .init(list: try .from(dto: dto.list))
    }
}
