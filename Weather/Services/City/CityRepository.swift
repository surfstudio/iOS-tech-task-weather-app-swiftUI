//
//  CityRepository.swift
//  Weather
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation
import NodeKit

/// Эта сущность предоставляет интерфейс для работы с городами
/// В отличии от сервисов, репозиторий предоставляет функциональность завязанную на доменный контекст
protocol CityRepository {
    func getAllSaved() -> CacheContext<[CityDetailedEntity]>
    func getCityBy(name: String) -> Observer<CityDetailedEntity>
    func save(city: CityDetailedEntity) -> Observer<Void>
    func getCityDetails(by id: Int, coords: CoordEntity) -> CacheContext<CityDetailedEntity>
}
