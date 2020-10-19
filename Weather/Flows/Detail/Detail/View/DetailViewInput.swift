//
//  DetailViewInput.swift
//  Weather
//

import SurfUtils

protocol DetailViewInput: class, LoaderDisplayable, SnackDisplayable, StateConfigurable {
    func setupInitialState(weather: CityDetailedEntity)
    func set(navigationBarStyle: UIStyle<UINavigationBar>)
}
