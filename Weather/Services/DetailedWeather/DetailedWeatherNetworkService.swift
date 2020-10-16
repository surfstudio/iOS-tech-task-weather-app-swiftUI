//
//  DetailedWeatherNetworkService.swift
//  Weather
//

import NodeKit

struct DetailedWeatherNetworkService: DetailedWeatherService {

    private enum Consts {

        static let latQueryParam = "lat"
        static let lonQueryParam = "lon"
        static let excludeQueryParam = "exclude"

        static let query: Json = [
            "appid": ServicesConstants.Weather.apiKey,
            "units": "metric",
            "lang": Locale.current.collatorIdentifier ?? Locale.current.identifier
        ]
    }

    private var builder: UrlChainsBuilder<DetailedWeatherUrlProvider> {
        return .init()
    }

    func getDetailedWeather(by coords: CoordEntity) -> Observer<DetailedWeatherEntity> {
        var query = Consts.query
        query[Consts.latQueryParam] = coords.lat
        query[Consts.lonQueryParam] = coords.lon
        query[Consts.excludeQueryParam] = [
            WeatherDataType.alerts,
            WeatherDataType.current
        ]

        return self.builder
            .route(.get, .getDetails)
            .set(query: query)
            .set(arrayEncodingStrategy: .noBrackets)
            .build()
            .process()
    }
}
