//
//  GeocodingService.swift
//  WeatherDebug
//

import NodeKit

protocol GeocodingService {
    /// Возвращает список возможных мест, названия которых похожи на `address`
    func getAddressAutocompleteSuggestion(address: String) -> Observer<[PlacesSuggestionEntity]>
}
