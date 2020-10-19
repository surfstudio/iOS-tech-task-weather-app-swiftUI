//
//  CityCacheService.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import NodeKit

struct CityCacheResponse {
    let city: CachedModel<CityDetailedEntity>
    let weather: CachedModel<DetailedWeatherEntity>?
}

protocol CityCacheService {

    typealias CachedCity = CachedModel<CityDetailedEntity>

    func get(by id: Int) -> Observer<CityCacheResponse>
    func getAll() -> Observer<[CachedCity]>
    func delete(by id: Int) -> Observer<Void>
    func save(cites: [CityDetailedEntity]) -> Observer<Void>
    func save(detailedWeather: DetailedWeatherEntity, for city: CityDetailedEntity) -> Observer<Void>
    func getCityBy(coords: CoordEntity) -> Observer<CityCacheResponse>
}
