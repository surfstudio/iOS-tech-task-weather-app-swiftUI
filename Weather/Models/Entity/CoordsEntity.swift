//
//  CoordsEntity.swift
//  WeatherDebug
//

import NodeKit

struct CoordEntity {
    let lon: Double
    let lat: Double
}

extension CoordEntity: DTODecodable {
    static func from(dto: CoordEntry) throws -> CoordEntity {
        .init(lon: dto.lon, lat: dto.lat)
    }
}
