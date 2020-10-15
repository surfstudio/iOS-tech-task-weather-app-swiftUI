//
//  AddCityModuleConfiguratorTests.swift
//  Weather
//

import XCTest
@testable import WeatherRelease

final class AddCityModuleConfiguratorTests: XCTestCase {

    // MARK: - Tests

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, input) = AddCityModuleConfigurator().configure()
            return (view, [input])
        })
    }

}