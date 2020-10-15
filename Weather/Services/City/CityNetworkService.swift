//
//  CityNetworkService.swift
//  WeatherDebug
//

import NodeKit

struct CityNetworkService: CityService {

    private enum Consts {

        static let getCityNameQueryParameter = "q"
        static let getGroupQueryParameter = "id"

        static let query: Json = [
            "appid": ServicesConstants.Weather.apiKey
        ]
    }

    private var builder: UrlChainsBuilder<CityUrlProvider> {
        return .init()
    }

    /// Если города с таким именем не нашлось - вернет `ResponseHttpErrorProcessorNodeError.notFound`
    func getCityDetailedWeather(by name: String) -> Observer<CityDetailedWeatherEntity> {
        var query = Consts.query
        query[Consts.getCityNameQueryParameter] = name
        return self.builder
            .route(.get, .getCityWeather)
            .set(query: query)
            .build()
            .process()
    }

    /// Если города с таким именем не нашлось - вернет `ResponseHttpErrorProcessorNodeError.notFound`
    func getCitiesDetailedWeather(by ids: [String]) -> Observer<[CityDetailedWeatherEntity]> {
        var query = Consts.query
        query[Consts.getGroupQueryParameter] = ids
        return self.builder
            .route(.get, .getSeverCitiesWeather)
            .set(query: query)
            .set(arrayEncodingStrategy: .noBrackets)
            .build()
            .process()
    }
}
