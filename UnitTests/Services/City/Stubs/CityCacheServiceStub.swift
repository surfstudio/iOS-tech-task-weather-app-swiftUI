//
//  CityCacheServiceStub.swift
//  UnitTests
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation
import NodeKit

@testable import WeatherDebug

final class CityCacheServiceStub: CityCacheService {

    var getId: Int?
    var deleteId: Int?
    var saveCities: [CityDetailedEntity]?
    var saveDetailedWeather: DetailedWeatherEntity?
    var saveCity: CityDetailedEntity?

    var getAllResponse: AsyncContext<[CachedCity]>?
    var getResult: AsyncContext<CityCacheResponse>?
    var deleteResult: AsyncContext<Void>?
    var saveResult: AsyncContext<Void>?
    var saveWeatherResult: AsyncContext<Void>?

    func get(by id: Int) -> Observer<CityCacheResponse> {
        self.getId = id
        return self.getResult ?? Context<CityCacheResponse>()
    }

    func getAll() -> Observer<[CachedCity]> {
        return self.getAllResponse ?? Context<[CachedCity]>()
    }

    func delete(by id: Int) -> Observer<Void> {
        self.deleteId = id
        return self.deleteResult ?? Context<Void>()
    }

    func save(cites: [CityDetailedEntity]) -> Observer<Void> {
        self.saveCities = cites
        return self.saveResult ?? Context<Void>()
    }

    func save(detailedWeather: DetailedWeatherEntity, for city: CityDetailedEntity) -> Observer<Void> {
        self.saveDetailedWeather = detailedWeather
        self.saveCity = city
        return self.saveWeatherResult ?? Context<Void>()
    }
}
