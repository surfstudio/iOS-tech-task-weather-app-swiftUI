//
//  DetailPresenter.swift
//  Weather
//

import SurfUtils

final class DetailPresenter: DetailViewOutput, DetailModuleInput, DetailModuleOutput {

    // MARK: - DetailModuleOutput

    var didShowCities: EmptyClosure?

    // MARK: - Properties

    weak var view: DetailViewInput?

    // MARK: - Private Properties

    private let repository: CityRepository
    private let geoService: GeolocationService
    private var city: CityDetailedEntity?
    private var isEmpty = false

    // MARK: - Lifecycle

    init(repository: CityRepository, geoService: GeolocationService) {
        self.repository = repository
        self.geoService = geoService
    }

    // MARK: - DetailViewOutput

    func viewLoaded() {
        if city != nil {
            loadWeather()
        } else {
            geoService.requestAuthorization { [weak self] result in
                switch result {
                case .success, .failure, .denied:
                    self?.loadCityWithWeather()
                case .requesting:
                    break
                }
            }
        }
    }

    func didReload() {
        if isEmpty {
            isEmpty = false
            didShowCities?()
        } else if city != nil {
            loadCityWithWeather()
        } else {
            loadWeather()
        }
    }

    func didTapOnList() {
        didShowCities?()
    }

    // MARK: - DetailModuleInput

    func set(city: CityDetailedEntity) {
        self.city = city
        loadWeather()
    }
}

// MARK: - Private Methods

private extension DetailPresenter {
    func loadCityWithWeather() {
        view?.startLoader()

        geoService.getCurrentLocation { [weak self] result in
            switch result {
            case .success(let loc):
                let coords = CoordEntity(lon: loc.coordinate.longitude,
                                         lat: loc.coordinate.latitude)
                self?.repository.getCityBy(coords: coords)
                    .onCompleted { [weak self] weather in
                        self?.view?.setupInitialState(weather: weather)
                    }.onError { [weak self] error in
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
            case .denied, .error:
                self?.isEmpty = true
                self?.view?.stopLoader()
                self?.view?.set(state: .empty(.init(Localized.Empty.cities,
                                                    action: Localized.Common.Button.addCity)))
            }
        }
    }

    func loadWeather() {
        guard let city = city else { return }

        view?.startLoader()

        repository.getCityDetails(by: city.cityId, coords: city.coords)
            .onCompleted { [weak self] weather in
                self?.view?.setupInitialState(weather: weather)
            }.onError { [weak self] error in
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
}
