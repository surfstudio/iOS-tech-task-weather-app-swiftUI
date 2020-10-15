//
//  PlacesSuggestion.swift
//  WeatherDebug
//

import NodeKit

struct PlacesSuggestionEntry: Codable {
    let display_name: String
}

extension PlacesSuggestionEntry: RawMappable {
    typealias Raw = Json
}
