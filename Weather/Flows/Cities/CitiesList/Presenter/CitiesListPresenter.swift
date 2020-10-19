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

    // MARK: - CitiesListViewOutput

    func viewLoaded() {
        view?.setupInitialState()
        self.loadCities()
    }
}

// MARK: - CitiesListViewOutput

extension CitiesListPresenter: CitiesListViewOutput {
    func didSelect(city: CityDetailedEntity) {
        self.didSelectCity?(city)
    }

    func didAddCitySelected() {
        self.didAddCity?()
    }
}

// MARK: - Private Methods

private extension CitiesListPresenter {
    func loadCities() {
        self.citiesRepo
            .getAllSaved()
            .onCacheSuccess { (data, isExpired) in
                self.view?.show(cities: data)
                if isExpired {
                    self.view?.showSnack(with: L10n.Error.dataIsExpired)
                }
            }.onLoadingStarted {
                self.view?.showLoaderView()
            }.onCompleted { data in
                self.view?.show(cities: data)
            }.onError { err in
                self.view?.show(error: err)
            }
    }
}
