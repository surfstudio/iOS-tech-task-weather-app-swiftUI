//
//  CityCacheService.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import NodeKit

struct CityCacheResponse {
    let city: CachedModel<CityDetailedWeatherEntity>
    let weather: CachedModel<DetailedWeatherEntity>?
}

protocol CityCacheService {

    typealias CachedCity = CachedModel<CityDetailedWeatherEntity>

    func get(by id: Int) -> Observer<CityCacheResponse>
    func getAll() -> Observer<[CachedCity]>
    func delete(by id: Int) -> Observer<Void>
    func save(cites: [CityDetailedWeatherEntity]) -> Observer<Void>
    func save(detailedWeather: DetailedWeatherEntity, for cityId: Int) -> Observer<Void>
}
