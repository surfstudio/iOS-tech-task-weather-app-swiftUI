//
//  CityWeatherConditionsEntity.swift
//  WeatherDebug
//

import NodeKit

struct CityWeatherConditionsEntity {
    let id: Int
    let main: String
    let description: String
    let icon: String
    let type: WeatherType
}

extension CityWeatherConditionsEntity: DTODecodable {
    static func from(dto: CityWeatherConditionsEntry) throws -> CityWeatherConditionsEntity {
        return .init(id: dto.id,
                     main: dto.main,
                     description: dto.description,
                     icon: dto.icon,
                     type: .init(typeId: dto.id))
    }
}
