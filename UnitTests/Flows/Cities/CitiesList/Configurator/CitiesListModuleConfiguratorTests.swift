//
//  CitiesListModuleConfiguratorTests.swift
//  Weather
//

import XCTest
@testable import WeatherRelease

final class CitiesListModuleConfiguratorTests: XCTestCase {

    // MARK: - Tests

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, input) = CitiesListModuleConfigurator().configure()
            return (view, [input])
        })
    }

}