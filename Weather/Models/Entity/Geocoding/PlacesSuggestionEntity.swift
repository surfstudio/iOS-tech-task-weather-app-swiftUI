//
//  PlacesSuggestionEntity.swift
//  UnitTests
//

import NodeKit

struct PlacesSuggestionEntity {
    let displayName: String
    let lat: Double
    let lon: Double
}

extension PlacesSuggestionEntity: DTODecodable {
    static func from(dto: PlacesSuggestionEntry) throws -> PlacesSuggestionEntity {
        .init(displayName: dto.display_name,
              lat: Double(dto.lat) ?? -1,
              lon: Double(dto.lon) ?? -1)
    }
}
