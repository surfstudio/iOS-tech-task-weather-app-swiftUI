//
//  PlacesSuggestionEntity.swift
//  UnitTests
//

import NodeKit

struct PlacesSuggestionEntity {
    let displayName: String
}

extension PlacesSuggestionEntity: DTODecodable {
    static func from(dto: PlacesSuggestionEntry) throws -> PlacesSuggestionEntity {
        .init(displayName: dto.display_name)
    }
}
