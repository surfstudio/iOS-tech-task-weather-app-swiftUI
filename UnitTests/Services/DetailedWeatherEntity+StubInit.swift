//
//  DetailedWeatherEntity+StubInit.swift
//  UnitTests
//
//  Created by Александр Кравченков on 19.10.2020.
//

import Foundation
@testable import WeatherDebug

extension DetailedWeatherEntity {
    init() {
        self.init(daily: nil, hourly: nil, minutely: nil)
    }
}
