//
//  MainViewInput.swift
//  Weather
//

protocol MainViewInput: class, LoaderDisplayable, SnackDisplayable, StateConfigurable {
    func setupInitialState(citites: [CityDetailedWeatherEntity])
}
