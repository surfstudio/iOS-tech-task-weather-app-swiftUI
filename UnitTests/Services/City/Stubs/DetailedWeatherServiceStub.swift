//
//  DetailedWeatherServiceStub.swift
//  UnitTests
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation
import NodeKit

@testable import WeatherDebug

final class DetailedWeatherServiceStub: DetailedWeatherService {

    var coords: CoordEntity?
    var result: AsyncContext<DetailedWeatherEntity>?

    func getDetailedWeather(by coords: CoordEntity) -> Observer<DetailedWeatherEntity> {
        self.coords = coords
        return result ?? Context<DetailedWeatherEntity>()
    }
}
