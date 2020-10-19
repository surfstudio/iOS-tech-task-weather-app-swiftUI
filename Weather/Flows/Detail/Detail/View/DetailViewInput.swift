//
//  DetailViewInput.swift
//  Weather
//

protocol DetailViewInput: class, LoaderDisplayable, SnackDisplayable, StateConfigurable {
    func setupInitialState(weather: CityDetailedEntity)
}
