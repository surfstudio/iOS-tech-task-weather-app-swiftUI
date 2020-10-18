//
//  AddCityViewTests.swift
//  Weather
//

import XCTest
@testable import WeatherRelease

final class AddCityViewTests: XCTestCase {

    // MARK: - Properties

    private var view: AddCityViewController?
    private var output: AddCityViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = AddCityViewController()
        output = AddCityViewOutputMock()
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

    final class AddCityViewOutputMock: AddCityViewOutput {
        var viewLoadedWasCalled: Bool = false

        func viewLoaded() {
            viewLoadedWasCalled = true
        }
    }

}
