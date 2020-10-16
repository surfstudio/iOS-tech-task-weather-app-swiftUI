//
//  CityWeatherConditionsEntity.swift
//  WeatherDebug
//

import NodeKit

struct WeatherConditionsEntity {
    let id: Int
    let main: String?
    let description: String?
    let type: WeatherType
}

extension WeatherConditionsEntity: DTODecodable {
    static func from(dto: WeatherConditionsEntry) throws -> WeatherConditionsEntity {
        return .init(id: dto.id,
                     main: dto.main,
                     description: dto.description,
                     type: .init(typeId: dto.id))
    }
}
