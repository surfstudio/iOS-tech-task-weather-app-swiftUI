//
//  CityUrl.swift
//  WeatherDebug
//

import NodeKit

enum CityUrlProvider {
    case getCityWeather
    case getSeverCitiesWeather
}

extension CityUrlProvider: UrlRouteProvider {
    func url() throws -> URL {
        switch self {
        case .getCityWeather:
            return try ServicesConstants.Weather.baseUrl + "/weather"
        case .getSeverCitiesWeather:
            return try ServicesConstants.Weather.baseUrl + "/group"
        }
    }
}
