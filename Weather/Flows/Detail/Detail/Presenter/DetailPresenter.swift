//
//  DetailPresenter.swift
//  Weather
//

final class DetailPresenter: DetailViewOutput, DetailModuleInput, DetailModuleOutput {

    // MARK: - DetailModuleOutput

    // MARK: - Properties

    weak var view: DetailViewInput?

    // MARK: - Private Properties

    private let service: DetailedWeatherService

    // MARK: - Lifecycle

    init(service: DetailedWeatherService) {
        self.service = service
    }

    // MARK: - DetailViewOutput

    func viewLoaded() {
        loadWeather()
    }

    func didReload() {
        loadWeather()
    }

    // MARK: - DetailModuleInput

}

// MARK: - Private Methods

private extension DetailPresenter {
    func loadWeather() {
        view?.startLoader()

        // FIXME: - Добавить запрос координат
        service.getDetailedWeather(by: .init(lon: 49.6600700, lat: 58.5966500))
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
