//
//  DetailedWeatherService.swift
//  Weather
//

import NodeKit

protocol DetailedWeatherService {
    func getDetailedWeather(by coords: CoordEntity) -> Observer<DetailedWeatherEntity>
}
