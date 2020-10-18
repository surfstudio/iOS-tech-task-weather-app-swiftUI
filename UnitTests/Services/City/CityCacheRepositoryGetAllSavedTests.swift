//
//  CityCacheRepositoryTests.swift
//  UnitTests
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation
import XCTest

@testable import WeatherDebug

final class CityCacheRepositoryGetAllSavedTests: XCTestCase {

    enum StubError: Error {
        case testWhenCacheEmitError
    }

    /// Проверяет, что если кеш вернет ошибку - то ошибка будет проброшена выше
    func testWhenCacheEmitErrorThenErrorWillBeThrown() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        // Act

        cache.getAllResponse = .emit(error: StubError.testWhenCacheEmitError)

        var savedItem: [CityDetailedEntity]?
        var error: Error?
        var cacheItems: (model: [CityDetailedEntity], isExpired: Bool)?
        var onLoading = false

        let exp = self.expectation(description: #function)

        repo.getAllSaved()
            .onCompleted { savedItem = $0 }
            .onError { error = $0; exp.fulfill() }
            .onCacheSuccess { cacheItems = $0 }
            .onLoadingStarted { onLoading = true }

        wait(for: [exp], timeout: 2)

        // Assert

        XCTAssertNil(savedItem)
        XCTAssertNil(cacheItems)
        // доказательство того, что сервис не был вызван
        XCTAssertNil(cityNetwork.getCitiesDetailedWeatherIds)
        XCTAssertFalse(onLoading)
        XCTAssertNotNil(error as? StubError,
                        "Ожидается, что вернется StubError, а вернулось \(String(describing: error))")
    }

    /// Проверяем, что в случае если данные из кеша провечть удалось, то они будут заэмичены
    /// При этом если они не протухли то сервис работы с сеть вызван не будет
    func testWithoutExpiredItemsServiceWontCallAndCacheWillBeEmited() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        let errorResponse = CachedModel<CityDetailedEntity>(isExpired: false, value: .init(id: 10))

        // Act

        cache.getAllResponse = .emit(data: [errorResponse])

        var savedItem: [CityDetailedEntity]?
        var error: Error?
        var cacheItems: (model: [CityDetailedEntity], isExpired: Bool)?
        var onLoading = false

        let exp = self.expectation(description: #function)

        repo.getAllSaved()
            .onCompleted { savedItem = $0 }
            .onError { error = $0 }
            .onCacheSuccess { cacheItems = $0; exp.fulfill() }
            .onLoadingStarted { onLoading = true }

        wait(for: [exp], timeout: 2)

        // Assert

        XCTAssertNil(savedItem)
        XCTAssertNil(error)
        XCTAssertFalse(onLoading)
        XCTAssertNotNil(cacheItems, "Данные из кеша должны были прийти")
        XCTAssertFalse(cacheItems?.isExpired ?? true)
        // доказательство того, что сервис не был вызван
        XCTAssertNil(cityNetwork.getCitiesDetailedWeatherIds)
    }

    /// Проверяем, что в случае если кеш протух - запрос будет выполнен на сервер
    /// Проверка выполняется при наличии 1го протухшего и 1го непротухшего
    func testWithExpiredServiceWillBeCalled() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        let errorResponse = [
            CachedModel<CityDetailedEntity>(isExpired: false, value: .init(id: 10)),
            CachedModel<CityDetailedEntity>(isExpired: true, value: .init(id: 11))
        ]

        cityNetwork.getCityDetailedWeatherByIdsResult = .emit(data: [CityDetailedEntity(id: 11)])

        // Act

        cache.getAllResponse = .emit(data: errorResponse)

        var savedItem: [CityDetailedEntity]?
        var error: Error?
        var cacheItems: (model: [CityDetailedEntity], isExpired: Bool)?
        var onLoading = false

        let expCompleted = self.expectation(description: #function)
        let expLoading = self.expectation(description: #function)

        repo.getAllSaved()
            .onCompleted { savedItem = $0; expCompleted.fulfill() }
            .onError { error = $0 }
            .onCacheSuccess { cacheItems = $0 }
            .onLoadingStarted { onLoading = true; expLoading.fulfill() }

        wait(for: [expCompleted, expLoading], timeout: 2)

        // Assert

        XCTAssertNil(error)

        XCTAssertTrue(onLoading)
        XCTAssertNotNil(cacheItems, "Данные из кеша должны были прийти")
        XCTAssertTrue(cacheItems?.isExpired ?? false)
        XCTAssertNotNil(savedItem)
        XCTAssertEqual(cityNetwork.getCitiesDetailedWeatherIds, [11])
    }
}
