//
//  CityService.swift
//  WeatherDebug
//

import NodeKit

protocol CityService {
    /// Получает информацию о детальной погоде в одном городе по его имени
    func getCityDetailedWeather(by name: String) -> Observer<CityDetailedEntity>
    /// Получает информацию о детальной погоде в городах по их ID
    func getCitiesDetailedWeather(by ids: [Int]) -> Observer<[CityDetailedEntity]>
    func getCitiesDetailedWeather(by id: Int) -> Observer<CityDetailedEntity>
}
