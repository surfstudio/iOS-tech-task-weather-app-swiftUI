//
//  CityDetailedEntityStubInit.swift
//  UnitTests
//
//  Created by Александр Кравченков on 19.10.2020.
//

import Foundation

@testable import WeatherDebug

extension CityDetailedEntity {
    init(id: Int, base: String? = nil) {
        self.init(coords: .init(lon: 0, lat: 0),
                  weather: nil,
                  base: base,
                  main: nil,
                  wind: nil,
                  clouds: nil,
                  rain: nil,
                  snow: nil,
                  time: nil,
                  systemInfo: nil,
                  timezone: nil,
                  cityId: id,
                  cityName: nil,
                  detailedWeather: nil)
    }
}
