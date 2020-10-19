//
//  CitiesListPresenter.swift
//  Weather
//

final class CitiesListPresenter: CitiesListViewOutput, CitiesListModuleInput, CitiesListModuleOutput {

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
    }

    // MARK: - CitiesListModuleInput
}

private extension CitiesListPresenter {
    func loadCities() {
        self.citiesRepo
            .getAllSaved()
            .onCacheSuccess { (data, isExpired) in

            }.onLoadingStarted {

            }.onCompleted { data in

            }.onError { err

            }
    }
}
