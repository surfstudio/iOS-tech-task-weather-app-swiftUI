//
//  CityServiceStub.swift
//  UnitTests
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation
import NodeKit

@testable import WeatherDebug

final class CityServiceStub: CityService {

    var getCityDetailedWeatherName: String?
    var getCitiesDetailedWeatherIds: [Int]?
    var getCitiesDetailedWeather: Int?

    var getCityDetailedWeatherByNameResult: Observer<CityDetailedEntity>?
    var getCityDetailedWeatherByIdsResult: Observer<[CityDetailedEntity]>?
    var getCityDetailedWeatherByIdResult: Observer<CityDetailedEntity>?

    func getCityDetailedWeather(by name: String) -> Observer<CityDetailedEntity> {
        self.getCityDetailedWeatherName = name
        return self.getCityDetailedWeatherByNameResult ?? Context<CityDetailedEntity>()
    }

    func getCitiesDetailedWeather(by ids: [Int]) -> Observer<[CityDetailedEntity]> {
        self.getCitiesDetailedWeatherIds = ids
        return self.getCityDetailedWeatherByIdsResult ?? Context<[CityDetailedEntity]>()
    }

    func getCitiesDetailedWeather(by id: Int) -> Observer<CityDetailedEntity> {
        self.getCitiesDetailedWeather = id
        return self.getCityDetailedWeatherByIdResult ?? Context<CityDetailedEntity>()
    }
}
