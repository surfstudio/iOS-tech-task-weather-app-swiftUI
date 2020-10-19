//
//  MainViewTests.swift
//  Weather
//

import XCTest
@testable import WeatherRelease

final class MainViewTests: XCTestCase {

    // MARK: - Properties

    private var view: MainViewController?
    private var output: MainViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = MainViewController()
        output = MainViewOutputMock()
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

    final class MainViewOutputMock: MainViewOutput {
        var viewLoadedWasCalled: Bool = false

        func viewLoaded() {
            viewLoadedWasCalled = true
        }
    }

}
