//
//  GeocodingUrls.swift
//  WeatherDebug
//

import NodeKit

enum GeocodingUrlProvider {
    case lookUp
}

extension GeocodingUrlProvider: UrlRouteProvider {

    func url() throws -> URL {
        switch self {
        case .lookUp:
            return try ServicesConstants.Geocoding.baseUrl + "/search"
        }
    }
}
