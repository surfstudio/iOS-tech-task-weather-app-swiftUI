//
//  PlacesSuggestion.swift
//  WeatherDebug
//

import NodeKit

struct PlacesSuggestionEntry: Codable {
    let display_name: String
    let lat: String
    let lon: String
}

extension PlacesSuggestionEntry: RawMappable {
    typealias Raw = Json
}
