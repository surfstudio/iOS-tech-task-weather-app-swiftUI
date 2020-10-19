//
//  CitiesListModuleOutput.swift
//  Weather
//

protocol CitiesListModuleOutput: class {
    var didSelectCity: Closure<CityDetailedEntity>? { get set }
    var didAddCity: EmptyClosure? { get set }
}
