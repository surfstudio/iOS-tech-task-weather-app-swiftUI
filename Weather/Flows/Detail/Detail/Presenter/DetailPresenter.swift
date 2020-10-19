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
    private var isViewInNormalState = false

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

    func viewWillAppear() {
        if isViewInNormalState {
            view?.set(navigationBarStyle: .whiteTitleNavigationBar)
        } else {
            view?.set(navigationBarStyle: .blackTitleNavigationBar)
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
        self.view?.setupInitialState(weather: city)
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
                    .onCompleted { [weak self] city in
                        _ = self?.repository.save(city: city)
                        self?.handleSuccessCityLoading(city: city)
                    }.onCacheSuccess { [weak self] city, _ in
                        self?.handleSuccessCityLoading(city: city)
                    }.onError { [weak self] error in
                        if error.isNetwork {
                            self?.view?.set(state: .error(.init(Localized.Error.noInternetConnection,
                                                               action: Localized.Common.Button.repeat)))
                        } else {
                            self?.view?.set(state: .error(.init(Localized.Error.notDefined,
                                                               action: Localized.Common.Button.repeat)))
                        }
                        self?.isViewInNormalState = false
                        self?.view?.set(navigationBarStyle: .blackTitleNavigationBar)
                    }
            case .denied, .error:
                self?.isEmpty = true
                self?.view?.stopLoader()
                self?.view?.set(state: .empty(.init(Localized.Empty.cities,
                                                    action: Localized.Common.Button.addCity)))
                self?.isViewInNormalState = false
                self?.view?.set(navigationBarStyle: .blackTitleNavigationBar)
            }
        }
    }

    func loadWeather() {
        guard let city = city else { return }

        view?.startLoader()

        repository.getCityDetails(by: city.cityId, coords: city.coords)
            .onCompleted { [weak self] city in
                self?.handleSuccessCityLoading(city: city)
            }.onError { [weak self] error in
                if error.isNetwork {
                    self?.view?.set(state: .error(.init(Localized.Error.noInternetConnection,
                                                       action: Localized.Common.Button.repeat)))
                } else {
                    self?.view?.set(state: .error(.init(Localized.Error.notDefined,
                                                       action: Localized.Common.Button.repeat)))
                }
                self?.view?.set(navigationBarStyle: .blackTitleNavigationBar)
                self?.isViewInNormalState = false
                self?.view?.stopLoader()
            }.onCacheSuccess { [weak self] city, _ in
                self?.handleSuccessCityLoading(city: city)
            }
    }

    func handleSuccessCityLoading(city: CityDetailedEntity) {
        self.view?.setupInitialState(weather: city)
        self.view?.set(state: .normal)
        self.view?.set(navigationBarStyle: .whiteTitleNavigationBar)
        self.isViewInNormalState = true
        self.view?.stopLoader()
    }
}
