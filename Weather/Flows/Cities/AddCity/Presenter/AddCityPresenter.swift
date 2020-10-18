//
//  AddCityPresenter.swift
//  Weather
//

import Foundation

final class AddCityPresenter: AddCityViewOutput, AddCityModuleInput, AddCityModuleOutput {

    // MARK: - AddCityModuleOutput

    var didDismiss: EmptyClosure?
    var didGetCity: Closure<CityDetailedWeatherEntity>?

    // MARK: - Properties

    weak var view: AddCityViewInput?

    // MARK: - Private properties

    private let geoService: GeocodingService
    private let cityService: CityService
    private var searchWorkItem: DispatchWorkItem?

    // MARK: - Init

    init(geoService: GeocodingService, cityService: CityService) {
        self.geoService = geoService
        self.cityService = cityService
    }

    // MARK: - AddCityViewOutput

    func didSearch(query: String) {
        guard !query.isEmpty else { return }

        self.searchWorkItem?.cancel()

        let searchWorkItem = DispatchWorkItem { [weak self] in
            self?.search(by: query)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: searchWorkItem)
    }

    func didCancelTap() {
        didDismiss?()
    }

    func didSelect(city: PlacesSuggestionEntity) {
        getCity(by: city.displayName)
    }

    // MARK: - AddCityModuleInput

}

// MARK: - Private Methods

private extension AddCityPresenter {
    func search(by query: String) {
        view?.startLoader()
        geoService.getAddressAutocompleteSuggestion(address: query)
            .onCompleted { [weak self] entities in
                if entities.isEmpty {
                    self?.view?.update(citites: [])
                    self?.view?.set(state: .empty(.init(Localized.Empty.request,
                                                        action: Localized.Common.Button.repeat)))
                } else {
                    self?.view?.update(citites: entities)
                    self?.view?.set(state: .normal)
                }
            }.onError { [weak self] error in
                self?.view?.update(citites: [])
                if error.isNetwork {
                    self?.view?.set(state: .error(.init(Localized.Error.noInternetConnection,
                                                       action: Localized.Common.Button.repeat)))
                } else {
                    self?.view?.set(state: .error(.init(Localized.Error.notDefined,
                                                       action: Localized.Common.Button.repeat)))
                }
            }.defer { [weak self] in
                self?.view?.stopLoader()
            }
    }

    func getCity(by name: String) {
        view?.startLoader()
        cityService.getCityDetailedWeather(by: name)
            .onCompleted { [weak self] city in
                self?.didGetCity?(city)
            }.onError { [weak self] error in
                self?.view?.show(error: error)
            }.defer { [weak self] in
                self?.view?.stopLoader()
            }
    }
}
