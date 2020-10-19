//
//  CitiesListViewInput.swift
//  Weather
//

protocol CitiesListViewInput: class, SnackDisplayable, MultiStatesPresentable {
    /// Method for setup initial state of view
    func setupInitialState()

    func show(cities: [CityDetailedEntity])
}
