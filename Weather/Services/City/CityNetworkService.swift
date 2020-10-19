//
//  CityNetworkService.swift
//  WeatherDebug
//

import NodeKit

struct CityNetworkService: CityService {

    private enum Consts {

        static let getCityNameQueryParameter = "q"
        static let getGroupQueryParameter = "id"
        static let getCoordsLatQueryParameter = "lat"
        static let getCoordsLonQueryParameter = "lon"

        static let query: Json = [
            "appid": ServicesConstants.Weather.apiKey,
            "units": "metric",
            "lang": Locale.current.languageCode ?? Locale.current.identifier
        ]
    }

    private var builder: UrlChainsBuilder<CityUrlProvider> {
        return .init()
    }

    /// Если города с таким именем не нашлось - вернет `ResponseHttpErrorProcessorNodeError.notFound`
    func getCityDetailedWeather(by name: String) -> Observer<CityDetailedEntity> {
        var query = Consts.query
        query[Consts.getCityNameQueryParameter] = name
        return self.builder
            .route(.get, .getCityWeather)
            .set(query: query)
            .build()
            .process()
    }

    /// Если города с таким именем не нашлось - вернет `ResponseHttpErrorProcessorNodeError.notFound`
    func getCitiesDetailedWeather(by ids: [Int]) -> Observer<[CityDetailedEntity]> {
        var query = Consts.query
        query[Consts.getGroupQueryParameter] = ids
        return self.builder
            .route(.get, .getSeverCitiesWeather)
            .set(query: query)
            .set(arrayEncodingStrategy: .noBrackets)
            .build()
            .process()
            .map { (result: CityDetailedListEntity) in
                return .emit(data: result.list)
            }
    }

    func getCitiesDetailedWeather(by id: Int) -> Observer<CityDetailedEntity> {
        return self.getCitiesDetailedWeather(by: [id]).map { result in
            guard let item = result.first else {
                return .emit(error: ResponseHttpErrorProcessorNodeError.notFound)
            }
            return .emit(data: item)
        }
    }

    func getCityBy(coords: CoordEntity) -> Observer<CityDetailedEntity> {
        var query = Consts.query
        query[Consts.getCoordsLatQueryParameter] = coords.lat
        query[Consts.getCoordsLonQueryParameter] = coords.lon
        return self.builder
            .route(.get, .getCityWeather)
            .set(query: query)
            .build()
            .process()
    }

}
