//
//  AddCityModuleOutput.swift
//  Weather
//

protocol AddCityModuleOutput: class {
    var didDismiss: EmptyClosure? { get set }
    var didGetCity: Closure<CityDetailedEntity>? { get set }
}
