//
//  MainPresenter.swift
//  Weather
//

final class MainPresenter: MainViewOutput, MainModuleInput, MainModuleOutput {

    // MARK: - MainModuleOutput

    // MARK: - Properties

    weak var view: MainViewInput?

    // MARK: - Private Properties

    private let service: CityService

    // MARK: - Lifecycle

    init(service: CityService) {
        self.service = service
    }

    // MARK: - MainViewOutput

    func viewLoaded() {
        loadCities()
    }

    func didReload() {
        loadCities()
    }

    // MARK: - MainModuleInput

}

// MARK: - Private Methods

private extension MainPresenter {
    func loadCities() {
        view?.startLoader()

        service.getCitiesDetailedWeather(by: [])
            .onCompleted { [weak self] entities in
                self?.view?.setupInitialState(citites: entities)
                self?.view?.set(state: .normal)
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
