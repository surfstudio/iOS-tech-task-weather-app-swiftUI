//
//  AddCityModuleOutput.swift
//  Weather
//

protocol AddCityModuleOutput: class {
    var didDismiss: EmptyClosure? { get set }
    var didGetCity: Closure<CityDetailedWeatherEntity>? { get set }
}
