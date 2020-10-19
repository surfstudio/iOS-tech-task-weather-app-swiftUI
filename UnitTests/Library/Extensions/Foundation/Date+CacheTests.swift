//
//  Foundation.swift
//  UnitTests
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation
import XCTest
@testable import WeatherDebug

/// Кейсы:
///
/// 1. Если проверяемая дата больше current, то вернется false при ttl > 0
/// 2. Если проверяемая дата меньше current на 1 час, а ttl == 2 часа, то вернется false
/// 3. Если проверяемая дата меньше current на 1 час, а ttl == 30 минут, то вернется true
final class DateCacheExtensionTests: XCTestCase {

    /// Если проверяемая дата больше current, то вернется false при ttl > 0
    func testBiggerDateIsNotExpired() {
        // Arrange

        let date = Date().addingTimeInterval(60 * 60)
        let ttl = TimeInterval(10)

        // Act

        let result = date.isExpired(ttl: ttl)

        // Assert

        XCTAssertFalse(result,
                       "\(date) больше чем \(Date()) ==> при любом значении TTL должно вернуться false")
    }

    /// Если проверяемая дата меньше current на 1 час, а ttl == 2 часа, то вернется false
    func testLessWithOneHourTTLIsntExpired() {
        // Arrange

        let date = Date().addingTimeInterval(60 * 60 * -1)
        let ttl = TimeInterval(2 * 60 * 60)

        // Act

        let result = date.isExpired(ttl: ttl)

        // Assert

        XCTAssertFalse(result,
                       "\(date) меньше чем \(Date()) на 1h, при этом ttl = \(ttl) ==> дата не протухла")
    }

    /// Если проверяемая дата меньше current на 1 час, а ttl == 30 минут, то вернется true
    func testLessOnOneHourWithHalfHourTTLIsntExpired() {
        // Arrange

        let date = Date().addingTimeInterval(60 * 60 * -1)
        let ttl = TimeInterval(0.5 * 60.0 * 60.0)

        // Act

        let result = date.isExpired(ttl: ttl)

        // Assert

        XCTAssertTrue(result,
                       "\(date) меньше чем \(Date()) на 1h, при этом ttl = \(ttl) ==> дата протухла")
    }
}
