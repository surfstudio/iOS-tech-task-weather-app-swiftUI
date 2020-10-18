//
//  AddCityViewOutput.swift
//  Weather
//

protocol AddCityViewOutput {
    func didSearch(query: String)
    func didCancelTap()
    func didSelect(city: PlacesSuggestionEntity)
}
