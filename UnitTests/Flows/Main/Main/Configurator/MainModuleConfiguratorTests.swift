//
//  MainModuleConfiguratorTests.swift
//  Weather
//

import XCTest
@testable import WeatherRelease

final class MainModuleConfiguratorTests: XCTestCase {

    // MARK: - Tests

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, input) = MainModuleConfigurator().configure()
            return (view, [input])
        })
    }

}