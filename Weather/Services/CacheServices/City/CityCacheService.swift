//
//  CityCacheService.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import NodeKit

protocol CityCacheService {

    typealias CachedCity = CachedModel<CityDetailedWeatherEntity>

    func get(by id: Int) -> Observer<CachedCity>
    func getAll(limit: Int, offset: Int) -> Observer<[CachedCity]>
    func delete(by id: Int) -> Observer<Void>
    func save(city: CityDetailedWeatherEntity) -> Observer<Void>
}
