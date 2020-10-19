//
//  CitiesListViewInput.swift
//  Weather
//

protocol CitiesListViewInput: class, SnackDisplayable, LoaderDisplayable, StateConfigurable {
    func setupInitialState()
    func show(cities: [CityDetailedEntity])
}
