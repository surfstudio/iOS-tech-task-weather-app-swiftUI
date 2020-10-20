//
//  CitiesListPresenter.swift
//  Weather
//

final class CitiesListPresenter: CitiesListModuleInput, CitiesListModuleOutput {

    // MARK: - CitiesListModuleOutput

    var didSelectCity: Closure<CityDetailedEntity>?
    var didAddCity: EmptyClosure?

    // MARK: - Properties

    private var citiesRepo: CityRepository

    weak var view: CitiesListViewInput?

    init(citiesRepo: CityRepository) {
        self.citiesRepo = citiesRepo
    }
}

// MARK: - CitiesListViewOutput

extension CitiesListPresenter: CitiesListViewOutput {
    func viewLoaded() {
        view?.setupInitialState()
        self.loadCities()
    }

    func didSelect(city: CityDetailedEntity) {
        self.didSelectCity?(city)
    }

    func didAddCitySelected() {
        self.didAddCity?()
    }

    func didRemove(city: CityDetailedEntity) {
        _ = citiesRepo.delete(by: city.cityId)
    }

    func didReload() {
        loadCities()
    }
}

// MARK: - Private Methods

private extension CitiesListPresenter {
    func loadCities() {
        view?.startLoader()

        self.citiesRepo
            .getAllSaved()
            .onCacheSuccess { [weak self] (data, isExpired) in
                print("##CACHE \(data.count) \(data.map { $0.cityName })")
                self?.view?.stopLoader()
                self?.view?.show(cities: data)
                self?.view?.set(state: .normal)

                if isExpired {
                    self?.view?.showSnack(with: Localized.Error.dataIsExpired)
                }
            }.onCompleted { [weak self] data in
                print("##COMPL \(data.count) \(data.map { $0.cityName })")
                self?.view?.stopLoader()
                self?.view?.show(cities: data)
                self?.view?.set(state: .normal)
            }.onError { [weak self] err in
                self?.view?.stopLoader()

                if err.isNetwork {
                    self?.view?.set(state: .error(.init(Localized.Error.noInternetConnection,
                                                       action: Localized.Common.Button.repeat)))
                } else {
                    self?.view?.set(state: .error(.init(Localized.Error.notDefined,
                                                       action: Localized.Common.Button.repeat)))
                }
            }
    }
}
