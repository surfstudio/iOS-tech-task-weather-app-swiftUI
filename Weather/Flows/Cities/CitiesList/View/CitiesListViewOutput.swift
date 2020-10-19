//
//  CitiesListViewOutput.swift
//  Weather
//

protocol CitiesListViewOutput {
    func viewLoaded()
    func didSelect(city: CityDetailedEntity)
    func didAddCitySelected()
}
