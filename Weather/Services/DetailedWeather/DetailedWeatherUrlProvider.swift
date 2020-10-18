//
//  DetailedWeatherUrlProvider.swift
//  Weather
//

import NodeKit

enum DetailedWeatherUrlProvider {
    case getDetails
}

extension DetailedWeatherUrlProvider: UrlRouteProvider {
    func url() throws -> URL {
        switch self {
        case .getDetails:
            return try ServicesConstants.Weather.baseUrl + "/onecall"
        }
    }
}
