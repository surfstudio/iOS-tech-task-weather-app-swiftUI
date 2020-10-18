//
//  MainPresenterTests.swift
//  Weather
//

import XCTest
@testable import WeatherRelease

final class MainPresenterTest: XCTestCase {

    // MARK: - Properties

    private var presenter: MainPresenter?
    private var view: MockViewController?
    private var output: MockModuleOutput?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        presenter = MainPresenter()
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

    private final class MockViewController: MainViewInput {
        var setupInitialStateWasCalled: Bool = false

        func setupInitialState() {
            setupInitialStateWasCalled = true
        }
    }

    private final class MockModuleOutput {

    }

}
