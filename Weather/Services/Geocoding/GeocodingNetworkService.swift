//
//  GeocodingNetworkService.swift
//  WeatherDebug
//

import NodeKit

struct GeocodingNetworkService: GeocodingService {

    private enum Consts {

        static let lookUpQueryParameter = "q"

        static let lookUpHeaders = [
            "x-rapidapi-host": "forward-reverse-geocoding.p.rapidapi.com",
            "x-rapidapi-key": ServicesConstants.Geocoding.apiKey
        ]

        static let lookUpParams = [
            "format": "json",
            "polygon_threshold": "0",
            "accept-language": Locale.current.languageCode ?? Locale.current.identifier
        ]
    }

    private var builder: UrlChainsBuilder<GeocodingUrlProvider> {
        return .init()
    }

    func getAddressAutocompleteSuggestion(address: String) -> Observer<[PlacesSuggestionEntity]> {
        var query = Consts.lookUpParams
        query[Consts.lookUpQueryParameter] = address
        return self.builder
            .route(.get, .lookUp)
            .add(provider: Consts.lookUpHeaders)
            .set(query: query)
            .build()
            .process()
    }
}
