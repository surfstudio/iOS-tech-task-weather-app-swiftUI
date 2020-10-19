//
//  CityCacheRepositoryGetCityDetailsTests.swift
//  UnitTests
//
//  Created by Александр Кравченков on 19.10.2020.
//

import Foundation
import NodeKit
import XCTest

@testable import WeatherDebug

/// Кейсы
/// 1. Если из кеша не вернулось - пойти в сеть, при этом:
///     - Должен быть вызыван `onStartLoading`
///     - При успехе ответа `onCompleted`
///     - Модель должна быть сохранена в кеш
/// 2. Если из кеша не вернулось и из сети тоже, то:
///     - Должен быть вызыван `onStartLoading`
///     - Должен быть вызыван `onError`
/// 3. Если из кеша вернулись данные и они не протухли, то:
///     - НЕ должен быть вызыван `onStartLoading`
///     - НЕ должен быть вызван сервис городов и погоды
///     - Должен быть вызыван `onCacheSuccess`
/// 4. Если из кеша вернулись данные, но без погоды, то:
///     - Должен быть вызыван `onCacheSuccess`
///     - Погода должна быть запрошена с бека
///     - Должен быть вызыван `onStartLoading`
///     - При успехе ответа `onCompleted`
///     - Погода запишется в кеш
/// 5. Если из кеша вернулись данные, но без погоды, и при этом кеш города протух, то:
///     - Будет вызыван `onCacheSuccess` с погодой
///     - Будет вызван сервис города
///     - будет вызыван `onCompleted`
/// 6. Если из кеша вернулись данные, и город протух, то:
///     - Должен быть вызыван `onStartLoading`
///     - Будет перезапрошен город
///     - Должен быть вызыван `onCacheSuccess`
///     - Город будет сохранен в кеш
///     - Будет вызыван `onCompleted`
/// 7. Если мз кеша вернулись данные и погода протухла, то:
///     - Должен быть вызыван `onCacheSuccess`
///     - Должен быть вызыван `onStartLoading`
///     - Будет перезапрошена погода
///     - Погода будет сохранена в кеш
///     - Будет вызыван `onCompleted`
final class CityCacheRepositoryGetCityDetailsTests: XCTestCase {

    ///1. Если из кеша не вернулось - пойти в сеть, при этом:
    ///     - Должен быть вызыван `onStartLoading`
    ///     - При успехе ответа `onCompleted`
    ///     - Модель должна быть сохранена в кеш
    func testWhenCacheReturnsError() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        // Act

        cache.getResult = AsyncContext().emit(error: StubError.testWhenCacheEmitError)
        cityNetwork.getCityDetailedWeatherByIdResult = AsyncContext().emit(data: .init(id: 11))
        weatherNetwork.result = AsyncContext().emit(data: .init())

        var savedItem: CityDetailedEntity?
        var error: Error?
        var cacheItems: (model: CityDetailedEntity, isExpired: Bool)?
        var onLoading = false

        let exp = self.expectation(description: #function)

        repo.getCityDetails(by: 1, coords: .init(lon: 1, lat: 1))
            .onCompleted { savedItem = $0; exp.fulfill() }
            .onError { error = $0 }
            .onCacheSuccess { cacheItems = $0 }
            .onLoadingStarted { onLoading = true }

        wait(for: [exp], timeout: 5)

        // Assert

        XCTAssertNil(error)
        XCTAssertNil(cacheItems)
        // доказательство того, что сервис был вызван
        XCTAssertNotNil(cityNetwork.getCitiesDetailedWeather)
        XCTAssertNotNil(weatherNetwork.coords)
        XCTAssertNotNil(savedItem)
        XCTAssertTrue(onLoading)
    }

    /// 2. Если из кеша не вернулось и из сети тоже, то:
    ///     - Должен быть вызыван `onStartLoading`
    ///     - Должен быть вызыван `onError`
    func testErrorWillBeThrownAfterCacheAndInternetError() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        // Act

        cache.getResult = AsyncContext().emit(error: StubError.testWhenCacheEmitError)
        cityNetwork.getCityDetailedWeatherByIdResult = AsyncContext().emit(error: StubError.testWhenCacheEmitError)
        weatherNetwork.result = AsyncContext().emit(data: .init())

        var savedItem: CityDetailedEntity?
        var error: Error?
        var cacheItems: (model: CityDetailedEntity, isExpired: Bool)?
        var onLoading = false

        let exp = self.expectation(description: #function)

        repo.getCityDetails(by: 1, coords: .init(lon: 1, lat: 1))
            .onCompleted { savedItem = $0 }
            .onError { error = $0; exp.fulfill() }
            .onCacheSuccess { cacheItems = $0 }
            .onLoadingStarted { onLoading = true }

        wait(for: [exp], timeout: 5)

        // Assert

        XCTAssertNotNil(error as? StubError,
                        "Должна вернуться `StubError` однко: \(String(describing: error))")
        XCTAssertNil(cacheItems)
        // доказательство того, что сервис был вызван
        XCTAssertNotNil(cityNetwork.getCitiesDetailedWeather)
        XCTAssertNil(savedItem)
        XCTAssertTrue(onLoading)
    }

    /// 3. Если из кеша вернулись данные и они не протухли, то:
    ///     - НЕ должен быть вызыван `onStartLoading`
    ///     - НЕ должен быть вызван сервис городов и погоды
    ///     - Должен быть вызыван `onCacheSuccess`
    func testValidCacheWasReturned() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        // Act

        cache.getResult = AsyncContext().emit(data: .init(city: .init(isExpired: false, value: .init(id: 11)),
                                                          weather: .init(isExpired: false, value: .init())))

        var savedItem: CityDetailedEntity?
        var error: Error?
        var cacheItems: (model: CityDetailedEntity, isExpired: Bool)?
        var onLoading = false

        let exp = self.expectation(description: #function)

        repo.getCityDetails(by: 1, coords: .init(lon: 1, lat: 1))
            .onCompleted { savedItem = $0 }
            .onError { error = $0 }
            .onCacheSuccess { cacheItems = $0; exp.fulfill() }
            .onLoadingStarted { onLoading = true }

        wait(for: [exp], timeout: 5)

        // Assert

        XCTAssertNil(error)
        XCTAssertNotNil(cacheItems)
        XCTAssertFalse(cacheItems?.isExpired ?? true)
        // доказательство того, что сервис не был вызван
        XCTAssertNil(cityNetwork.getCitiesDetailedWeather)
        XCTAssertNil(weatherNetwork.coords)
        XCTAssertNil(savedItem)
        XCTAssertFalse(onLoading)
    }

    /// 4. Если из кеша вернулись данные, но без погоды, то:
    ///     - Должен быть вызыван `onCacheSuccess`
    ///     - Погода должна быть запрошена с бека
    ///     - Должен быть вызыван `onStartLoading`
    ///     - При успехе ответа вызыван `onCompleted`
    ///     - Погода запишется в кеш
    //      - Если город не протух - он не должен быть запрошен
    func testDateWithoutWeatherProduceWeatherNetworkRequest() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        // Act

        weatherNetwork.result = AsyncContext().emit(data: .init())
        cache.getResult = AsyncContext().emit(data: .init(city: .init(isExpired: false, value: .init(id: 11)),
                                                          weather: nil))

        var savedItem: CityDetailedEntity?
        var error: Error?
        var cacheItems: (model: CityDetailedEntity, isExpired: Bool)?
        var onLoading = false

        let exp = self.expectation(description: #function)

        repo.getCityDetails(by: 1, coords: .init(lon: 1, lat: 1))
            .onCompleted { savedItem = $0; exp.fulfill() }
            .onError { error = $0 }
            .onCacheSuccess { cacheItems = $0 }
            .onLoadingStarted { onLoading = true }

        wait(for: [exp], timeout: 5)

        // Assert

        XCTAssertNil(error)
        XCTAssertNotNil(cacheItems)
        XCTAssertFalse(cacheItems?.isExpired ?? true)
        // доказательство того, что сервис города не был вызван
        XCTAssertNil(cityNetwork.getCitiesDetailedWeather)
        // а это доказывает что сервис погоды БЫЛ вызван
        XCTAssertNotNil(weatherNetwork.coords)
        // так как onCompleted должен был быть вызыван
        XCTAssertNotNil(savedItem)
        // Так как мы получили погоду, то очевидно она не должна быть nil
        XCTAssertNotNil(savedItem?.detailedWeather)
        // Так как мы пошли в сеть
        XCTAssertTrue(onLoading)
    }

    /// 5. Если из кеша вернулись данные, но без погоды, и при этом кеш города протух, то:
    ///     - Будет вызыван `onCacheSuccess` с погодой
    ///     - Будет вызван сервис города
    ///     - будет вызыван `onCompleted`
    func testWhenWeatherDoesntExistAndCityExistInCacheButCityWasExpired() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        // Act

        weatherNetwork.result = AsyncContext().emit(data: .init())
        cache.getResult = AsyncContext().emit(data: .init(city: .init(isExpired: true, value: .init(id: 11)),
                                                          weather: nil))

        var savedItem: CityDetailedEntity?
        var error: Error?
        var cacheItems: (model: CityDetailedEntity, isExpired: Bool)?
        var onLoading = false

        let exp = self.expectation(description: #function)

        repo.getCityDetails(by: 1, coords: .init(lon: 1, lat: 1))
            .onCompleted { savedItem = $0; exp.fulfill() }
            .onError { error = $0 }
            .onCacheSuccess { cacheItems = $0 }
            .onLoadingStarted { onLoading = true }

        wait(for: [exp], timeout: 5)

        // Assert

        XCTAssertNil(error)
        XCTAssertNotNil(cacheItems)
        // так как onCompleted должен был быть вызыван
        XCTAssertNotNil(savedItem)
        // Доказательство того, что вызывался сервис города
        XCTAssertNotNil(cityNetwork.getCitiesDetailedWeather)
        // Так как мы пошли в сеть
        XCTAssertTrue(onLoading)
    }

    /// 6. Если из кеша вернулись данные, и город протух, то:
    ///     - Должен быть вызыван `onCacheSuccess`
    ///     - Должен быть вызыван `onStartLoading`
    ///     - Будет перезапрошен город
    ///     - Город будет сохранен в кеш
    ///     - Будет вызыван `onCompleted`
    func testDataExistButCityWasExpired() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        // Act

        cityNetwork.getCityDetailedWeatherByIdResult = AsyncContext().emit(data: .init(id: 11))
        cache.getResult = AsyncContext().emit(data: .init(city: .init(isExpired: true, value: .init(id: 11)),
                                                          weather: .init(isExpired: false, value: .init())))

        var savedItem: CityDetailedEntity?
        var error: Error?
        var cacheItems: (model: CityDetailedEntity, isExpired: Bool)?
        var onLoading = false

        let exp = self.expectation(description: #function)

        repo.getCityDetails(by: 1, coords: .init(lon: 1, lat: 1))
            .onCompleted { savedItem = $0; exp.fulfill() }
            .onError { error = $0 }
            .onCacheSuccess { cacheItems = $0 }
            .onLoadingStarted { onLoading = true }

        wait(for: [exp], timeout: 5)

        // Assert

        XCTAssertNil(error)
        XCTAssertNotNil(cacheItems)
        // так как onCompleted должен был быть вызыван
        XCTAssertNotNil(savedItem)
        // Доказательство того, что вызывался сервис города
        XCTAssertNotNil(cityNetwork.getCitiesDetailedWeather)
        // Доказательство того, что НЕ вызывался сервис погоды
        XCTAssertNil(weatherNetwork.coords)
        XCTAssertNotNil(cache.saveCities)
        // Так как мы пошли в сеть
        XCTAssertTrue(onLoading)
    }

    /// 7. Если мз кеша вернулись данные и погода протухла, то:
    ///     - Должен быть вызыван `onCacheSuccess`
    ///     - Должен быть вызыван `onStartLoading`
    ///     - Будет перезапрошена погода
    ///     - Погода будет сохранена в кеш
    ///     - Будет вызыван `onCompleted`
    func testDataExistButWeatherWasExpired() {
        // Arrange

        let cache = CityCacheServiceStub()
        let cityNetwork = CityServiceStub()
        let weatherNetwork = DetailedWeatherServiceStub()

        let repo = CityCacheRepository(cache: cache,
                                       cityNetwork: cityNetwork,
                                       weatherNetwork: weatherNetwork)

        // Act

        weatherNetwork.result = AsyncContext().emit(data: .init())
        cache.getResult = AsyncContext().emit(data: .init(city: .init(isExpired: false, value: .init(id: 11)),
                                                          weather: .init(isExpired: true, value: .init())))

        var savedItem: CityDetailedEntity?
        var error: Error?
        var cacheItems: (model: CityDetailedEntity, isExpired: Bool)?
        var onLoading = false

        let exp = self.expectation(description: #function)

        repo.getCityDetails(by: 1, coords: .init(lon: 1, lat: 1))
            .onCompleted { savedItem = $0; exp.fulfill() }
            .onError { error = $0 }
            .onCacheSuccess { cacheItems = $0 }
            .onLoadingStarted { onLoading = true }

        wait(for: [exp], timeout: 5)

        // Assert

        XCTAssertNil(error)
        XCTAssertNotNil(cacheItems)
        // так как onCompleted должен был быть вызыван
        XCTAssertNotNil(savedItem)
        // Доказательство того, что НЕ вызывался сервис города
        XCTAssertNil(cityNetwork.getCitiesDetailedWeather)
        // Доказательство того, что вызывался сервис погоды
        XCTAssertNotNil(weatherNetwork.coords)
        XCTAssertNotNil(cache.saveDetailedWeather)
        // Так как мы пошли в сеть
        XCTAssertTrue(onLoading)
    }
}
