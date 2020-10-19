//
//  CitiesListPresenterTests.swift
//  Weather
//

import XCTest
@testable import WeatherRelease

final class CitiesListPresenterTest: XCTestCase {

    // MARK: - Properties

    private var presenter: CitiesListPresenter?
    private var view: MockViewController?
    private var output: MockModuleOutput?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        presenter = CitiesListPresenter()
        output = MockModuleOutput()
        view = MockViewController()
        presenter?.view = view
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        view = nil
    }

    // MARK: - Main tests

    func testThatPresenterHandlesViewLoadedEvent() {
        // when 
        presenter?.viewLoaded()
        // then
        XCTAssertTrue((presenter?.view as? MockViewController)?.setupInitialStateWasCalled == true)
    }

    // MARK: - Mocks

    private final class MockViewController: CitiesListViewInput {
        var setupInitialStateWasCalled: Bool = false

        func setupInitialState() {
            setupInitialStateWasCalled = true
        }
    }

    private final class MockModuleOutput {

    }

}
