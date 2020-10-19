//
//  CitiesListViewTests.swift
//  Weather
//

import XCTest
@testable import WeatherRelease

final class CitiesListViewTests: XCTestCase {

    // MARK: - Properties

    private var view: CitiesListViewController?
    private var output: CitiesListViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = CitiesListViewController()
        output = CitiesListViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    func testThatViewNotifiesPresenterOnDidLoad() {
        // when
        self.view?.viewDidLoad()
        // then
        XCTAssert(self.output?.viewLoadedWasCalled == true)
    }

    // MARK: - Mocks

    final class CitiesListViewOutputMock: CitiesListViewOutput {
        var viewLoadedWasCalled: Bool = false

        func viewLoaded() {
            viewLoadedWasCalled = true
        }
    }

}
